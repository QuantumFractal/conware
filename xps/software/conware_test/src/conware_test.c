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
#include <stdlib.h>
#include "platform.h"
#include "xparameters.h"
#include "axi_dma_ftw.h"
#include "xaxidma.h"
//#include "xvtc.h"
//#include "xaxivdma.h"

#define ALIGN64(some_ptr) (int*)(some_ptr + XAXIDMA_BD_MINIMUM_ALIGNMENT-some_ptr%XAXIDMA_BD_MINIMUM_ALIGNMENT);

static XAxiDma AxiDma;
XAxiDma_Bd bd_template;

void print_desc(void * desc) {
	unsigned char * ptr = (unsigned char *) desc;
	int i;
	for (i = 0; i < 16; i++) {
		printf("%02x %02x %02x %02x \r\n", ptr[i*4+3], ptr[i*4+2], ptr[i*4+1], ptr[i*4]);
	}
}

#define SIZE 8

#define XST_CHECK(stmt, errmsg) \
	if ((stmt) != XST_SUCCESS) { \
		xil_printf(errmsg); \
		return -1; \
	}

int main()
{
	xil_printf("\r\n--- Entering main() --- \r\n");
    init_platform();
	xil_printf("\r\n--- Entering main() --- \r\n");

    u32 * grid = (u32 *) malloc((SIZE*sizeof(int)));
    u32 * grid_out = (u32 *) malloc((SIZE*sizeof(int)));
    int i, j;

    for (i = 0; i < SIZE; i++) {
    	if (i%2) {
    		grid[i] = 0x00000000;
    	}
    	else {
    		grid[i] = 0xFFFFFFFF;
    	}
    }

    memset(grid_out, 0x00, SIZE*sizeof(int));

    // Init DMA
	XAxiDma_Config *Config;

	Config = XAxiDma_LookupConfig(XPAR_AXIDMA_0_DEVICE_ID);
	if (!Config) {
		xil_printf("No config found for %d\r\n", XPAR_AXIDMA_0_DEVICE_ID);
		return XST_FAILURE;
	}

	XST_CHECK(XAxiDma_CfgInitialize(&AxiDma, Config), "Initialization failed %d\r\n");

	XAxiDma_Reset(&AxiDma);
	while (!XAxiDma_ResetIsDone(&AxiDma)) {}

	XAxiDma_BdClear(&bd_template);

	xil_printf("--- DMA Configured ---\n\r");

	XAxiDma_Bd* bd_ptr;
	XAxiDma_Bd* rx_bd_ptr;
	XAxiDma_Bd*	tx_bd_ptr;

	// TX BUFFER SHIT
	XAxiDma_BdRing * tx_ring = XAxiDma_GetTxRing(&AxiDma);
	int * tx_bd_mem = (int*) malloc((1+1)*XAXIDMA_BD_MINIMUM_ALIGNMENT);
	tx_bd_mem = ALIGN64((int)tx_bd_mem);

	XST_CHECK(XAxiDma_BdRingCreate(tx_ring, (int)tx_bd_mem, (int)tx_bd_mem, XAXIDMA_BD_MINIMUM_ALIGNMENT, 1), "ERROR! Failed to create Buffer.\r\n");
	XAxiDma_UpdateBdRingCDesc(tx_ring);
	XST_CHECK(XAxiDma_BdRingClone(tx_ring, &bd_template), "ERROR! Failed allocate buffer descriptors.\r\n");
	XST_CHECK(XAxiDma_BdRingAlloc(tx_ring, 1, &tx_bd_ptr), "ERROR! Failed to allocate locations in the buffer descriptor ring.\r\n");


	// RX BUFFER SHIT
	XAxiDma_BdRing * rx_ring = XAxiDma_GetRxRing(&AxiDma);
	int * rx_bd_mem = (int*) malloc((1+1)*XAXIDMA_BD_MINIMUM_ALIGNMENT); // +1 to account for worst case misalignment
	rx_bd_mem = ALIGN64((int)rx_bd_mem);

	XST_CHECK(XAxiDma_BdRingCreate(rx_ring, (int)rx_bd_mem, (int)rx_bd_mem, XAXIDMA_BD_MINIMUM_ALIGNMENT, 1), "ERROR! RX failed to create buffer ring\r\n");

	XAxiDma_UpdateBdRingCDesc(rx_ring);
	XST_CHECK(XAxiDma_BdRingClone(rx_ring, &bd_template), "ERROR! RX Failed allocate buffer descriptors.\r\n");
	XST_CHECK(XAxiDma_BdRingAlloc(rx_ring, XAxiDma_BdRingGetFreeCnt(rx_ring), &rx_bd_ptr), "ERROR! Failed to allocate locations in the buffer descriptor ring.\r\n");


	int tx_buf_addr = grid;
	int rx_buf_addr = grid_out;

	XST_CHECK(XAxiDma_BdSetBufAddr(tx_bd_ptr, tx_buf_addr), "ERROR! Failed to set source address for this BD.\r\n");
	XST_CHECK(XAxiDma_BdSetBufAddr(rx_bd_ptr, rx_buf_addr), "ERROR! Failed to set source address for this BD.\r\n");

	XST_CHECK(XAxiDma_BdSetLength(tx_bd_ptr, SIZE*sizeof(int), tx_ring->MaxTransferLen), "ERROR! Failed to set buffer length for this BD.\r\n");
	XST_CHECK(XAxiDma_BdSetLength(rx_bd_ptr, SIZE*sizeof(int), rx_ring->MaxTransferLen), "ERROR! Failed to set buffer length for this BD.\r\n");

	int cr_bits = 0;

	cr_bits |= XAXIDMA_BD_CTRL_TXSOF_MASK;
	cr_bits |= XAXIDMA_BD_CTRL_TXEOF_MASK;

	XAxiDma_BdSetCtrl(tx_bd_ptr, cr_bits);
	XAxiDma_BdSetCtrl(rx_bd_ptr, 0);

	XST_CHECK(XAxiDma_BdRingToHw(tx_ring, 1, tx_bd_ptr), "ERROR! Failed to pass buffer descriptor ring to the hardware. \n\r");
	XST_CHECK(XAxiDma_BdRingToHw(rx_ring, 1, rx_bd_ptr), "ERROR! Failed to pass buffer descriptor ring to the hardware. \n\r");

	Xil_DCacheFlush();


	for (j = 0; j < 8; j++) {

		XST_CHECK(XAxiDma_BdRingStart(tx_ring), "ERROR! Failed to kick off MM2S transfer.\n\r");
		XST_CHECK(XAxiDma_BdRingStart(rx_ring), "ERROR! Failed to kick off S2MM transfer.\n\r");

		volatile unsigned int * ptr = AxiDma.RegBase;
			printf("MM2S_DMASR: %x\r\n", ptr[1]);
			printf("S2MM_DMASR: %x\r\n", ptr[13]);

		Xil_DCacheFlush();

		for (i = 0; i < SIZE; i++) {
			printf("%d ", grid_out[i]?1:0);
		}
		printf("\r\n");
	}

    return 0;

}
