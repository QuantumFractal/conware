/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "axi_dma_ftw.h"
#include "xaxidma.h"

#define ALIGN64(some_ptr) (int*)(some_ptr + XAXIDMA_BD_MINIMUM_ALIGNMENT-some_ptr%XAXIDMA_BD_MINIMUM_ALIGNMENT);

static XAxiDma AxiDma;


void init_checkers(char * grid, int width, int height){
	int i;
	for(i=0; i<width*height; i++){
		if (i%4==0){
			grid[i] = 'x';
		} else {
			grid[i] = 'o';
		}
	}
}

void print_grid(char * grid, int width, int height){
	int i,j;
	for(i=0; i<height; i++){
		for(j=0; j<width; j++){
			xil_printf("%c", grid[i*width+j]);
		}
		xil_printf("\n\r");
	}
	xil_printf("\n\r");
}

int main()
{
    init_platform();
	xil_printf("\r\n--- Entering main() --- \r\n");

	int WIDTH = 16;
    int HEIGHT = 8;

    char * grid = (char *) malloc((WIDTH*HEIGHT*sizeof(char)));

    init_checkers(grid, WIDTH, HEIGHT);
    //print_grid(grid, WIDTH, HEIGHT);

    // DMA STUFF

    // Init DMA
    int Status;
	XAxiDma_Config *Config;
	XAxiDma_Bd      bd_template;
	XAxiDma_Bd*     bd_ptr;
	XAxiDma_Bd*		cur_bd_ptr;
	int i;

	/*
	 *	1. Init the DMA unit (init_dma)
	 */
	Config = XAxiDma_LookupConfig(XPAR_AXIDMA_0_DEVICE_ID);
	if (!Config) {
		xil_printf("No config found for %d\r\n", XPAR_AXIDMA_0_DEVICE_ID);

		return XST_FAILURE;
	}

	Status = XAxiDma_CfgInitialize(&AxiDma, Config);

	if (Status != XST_SUCCESS) {
		xil_printf("Initialization failed %d\r\n", Status);
		return XST_FAILURE;
	}

	if(XAxiDma_HasSg(&AxiDma)){
		xil_printf("Device configured as SG mode \r\n");
	}

	XAxiDma_Reset(&AxiDma);
	while (!XAxiDma_ResetIsDone(&AxiDma)) {}

    /*
	 *	2. Make a ring and update DMA (bd_ch_setup)
	 */
    XAxiDma_BdRing * tx_ring = XAxiDma_GetTxRing(&AxiDma);
    int * aligned_grid = ALIGN64((int)grid);
    int status = XAxiDma_BdRingCreate(tx_ring, aligned_grid, aligned_grid, 64, 5
    		);
    XAxiDma_UpdateBdRingCDesc(tx_ring);

	// Allocate BDs from template
	XAxiDma_BdClear(&bd_template);
	status = XAxiDma_BdRingClone(tx_ring, &bd_template);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed allocate buffer descriptors.\r\n");
		return -1;
	}

	// Ring buffer allocate
	status = XAxiDma_BdRingAlloc(tx_ring, 5, &bd_ptr);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to allocate locations in the buffer descriptor ring.\r\n");
		return -1;
	}

	/*
	 * 3. Populate BD's with commands
	 */
	cur_bd_ptr = bd_ptr;
	int buf_addr = (int *) malloc((5+1)*XAXIDMA_BD_MINIMUM_ALIGNMENT);
	if (buf_addr == NULL)
	{
		xil_printf("ERROR! Failed to allocate memory for S2MM BDs.\n\r");
		return -1;
	}


	int   cr_bits        = 0;
	for(i=0;i<5;i++){
		status = XAxiDma_BdSetBufAddr(cur_bd_ptr, buf_addr);
		if (status != XST_SUCCESS)
		{
			xil_printf("ERROR! Failed to set source address for this BD.\r\n");
			return -1;
		}

		// Set length of buffer
		status = XAxiDma_BdSetLength(cur_bd_ptr, 5, tx_ring->MaxTransferLen);
		if (status != XST_SUCCESS)
		{
			xil_printf("ERROR! Failed to set buffer length for this BD.\r\n");
			return -1;
		}

		// Set control bits for TX side
		if (1)
		{
			if (i == 0)
			{
				cr_bits |= XAXIDMA_BD_CTRL_TXSOF_MASK; // Set SOF (tuser) for first BD
			}

			cr_bits |= XAXIDMA_BD_CTRL_TXEOF_MASK; // Sets tlast to generate an interrupt. Coalescing is set to interrupt once per ring
		}

		// Set control register
		XAxiDma_BdSetCtrl(cur_bd_ptr, cr_bits);

		// Increment pointer address to the next BD
		buf_addr += 5;

		// Advance current BD pointer for next iteration
		cur_bd_ptr = XAxiDma_BdRingNext(tx_ring, cur_bd_ptr);
	}

	status = XAxiDma_BdRingToHw(tx_ring, 5, bd_ptr); // This function manages cache coherency for BDs
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to pass buffer descriptor ring to the hardware. \n\r");
		return -1;
	}

	/*
	 * 4. SEND IT
	 */
	status = XAxiDma_BdRingStart(tx_ring);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to kick off S2MM transfer.\n\r");
		return -1;
	}

	sleep(5000);

    xil_printf("---------[END]---------\n\r");
    return 0;
}
