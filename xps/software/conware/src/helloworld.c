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

void print_desc(void * desc) {
	unsigned char * ptr = (unsigned char *) desc;
	int i;
	for (i = 0; i < 16; i++) {
		printf("%02x %02x %02x %02x \r\n", ptr[i*4+3], ptr[i*4+2], ptr[i*4+1], ptr[i*4]);
	}
}

#define SIZE 8


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

    // DMA STUFF

    // Init DMA
    int status;
	XAxiDma_Config *Config;
	XAxiDma_Bd      bd_template;
	XAxiDma_Bd		rx_template;
	XAxiDma_Bd*     bd_ptr;
	XAxiDma_Bd*		rx_bd_ptr;
	XAxiDma_Bd*		tx_bd_ptr;

	/*
	 *	1. Init the DMA unit (init_dma)
	 */
	Config = XAxiDma_LookupConfig(XPAR_AXIDMA_0_DEVICE_ID);
	if (!Config) {
		xil_printf("No config found for %d\r\n", XPAR_AXIDMA_0_DEVICE_ID);

		return XST_FAILURE;
	}

	status = XAxiDma_CfgInitialize(&AxiDma, Config);

	if (status != XST_SUCCESS) {
		xil_printf("Initialization failed %d\r\n", status);
		return XST_FAILURE;
	}

	if(XAxiDma_HasSg(&AxiDma)){
		xil_printf("Device configured as SG mode \r\n");
	}

	XAxiDma_Reset(&AxiDma);
	while (!XAxiDma_ResetIsDone(&AxiDma)) {}


	xil_printf("--- DMA Configured ---\n\r");

    /*
	 *	2. Make a ring and update DMA (bd_ch_setup)
	 */
    XAxiDma_BdRing * tx_ring = XAxiDma_GetTxRing(&AxiDma);
	int * tx_bd_mem = (int*) malloc((1+1)*XAXIDMA_BD_MINIMUM_ALIGNMENT); // +1 to account for worst case misalignment
    tx_bd_mem = ALIGN64((int)tx_bd_mem);
    status = XAxiDma_BdRingCreate(tx_ring, (int)tx_bd_mem, (int)tx_bd_mem, XAXIDMA_BD_MINIMUM_ALIGNMENT, 1);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to create Buffer.\r\n");
		return -1;
	}

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
	status = XAxiDma_BdRingAlloc(tx_ring, 1, &tx_bd_ptr);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to allocate locations in the buffer descriptor ring.\r\n");
		return -1;
	}

	// DO IT AGAIN
	// RX
	// RX
	// RX
	//
    XAxiDma_BdRing * rx_ring = XAxiDma_GetRxRing(&AxiDma);
	int * rx_bd_mem = (int*) malloc((1+1)*XAXIDMA_BD_MINIMUM_ALIGNMENT); // +1 to account for worst case misalignment
    rx_bd_mem = ALIGN64((int)rx_bd_mem);
    status = XAxiDma_BdRingCreate(rx_ring, (int)rx_bd_mem, (int)rx_bd_mem, XAXIDMA_BD_MINIMUM_ALIGNMENT, 1);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! RX failed to create buffer ring\r\n");
		return -1;
	}

    XAxiDma_UpdateBdRingCDesc(rx_ring);

	// Allocate BDs from template
	XAxiDma_BdClear(&rx_template);
	status = XAxiDma_BdRingClone(rx_ring, &bd_template);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! RX Failed allocate buffer descriptors.\r\n");
		return -1;
	}

	// Ring buffer allocate
	int freebd = XAxiDma_BdRingGetFreeCnt(rx_ring);
	status = XAxiDma_BdRingAlloc(rx_ring, freebd, &rx_bd_ptr);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to allocate locations in the buffer descriptor ring.\r\n");
		return -1;
	}

	xil_printf("--- BD Allocated ---\n\r");

	/*
	 * 3. Populate BD's with commands
	 */
	int tx_buf_addr = grid;

	if (tx_buf_addr == NULL)
	{
		xil_printf("ERROR! Failed to allocate memory for S2MM BDs.\n\r");
		return -1;
	}

	int rx_buf_addr = grid_out;
	memset(rx_buf_addr, 0x55, SIZE*sizeof(int));

	if (rx_buf_addr == NULL)
	{
		xil_printf("ERROR! Failed to allocate memory for S2MM BDs.\n\r");
		return -1;
	}

	int   cr_bits = 0;

	status = XAxiDma_BdSetBufAddr(tx_bd_ptr, tx_buf_addr);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to set source address for this BD.\r\n");
		return -1;
	}

	status = XAxiDma_BdSetBufAddr(rx_bd_ptr, rx_buf_addr);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to set source address for this BD.\r\n");
		return -1;
	}


	// Set length of buffer
	status = XAxiDma_BdSetLength(tx_bd_ptr, SIZE*sizeof(int), tx_ring->MaxTransferLen);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to set buffer length for this BD.\r\n");
		return -1;
	}

	// Set length of buffer
	status = XAxiDma_BdSetLength(rx_bd_ptr, SIZE*sizeof(int), rx_ring->MaxTransferLen);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to set buffer length for this BD.\r\n");
		return -1;
	}

	// Set control bits for start and end of file
	cr_bits |= XAXIDMA_BD_CTRL_TXSOF_MASK; // Set SOF (tuser) for first BD
	cr_bits |= XAXIDMA_BD_CTRL_TXEOF_MASK;

	// Set control register
	XAxiDma_BdSetCtrl(tx_bd_ptr, cr_bits);
	XAxiDma_BdSetCtrl(rx_bd_ptr, 0);


	status = XAxiDma_BdRingToHw(tx_ring, 1, tx_bd_ptr); // This function manages cache coherency for BDs
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to pass buffer descriptor ring to the hardware. \n\r");
		return -1;
	}



	status = XAxiDma_BdRingToHw(rx_ring, 1, rx_bd_ptr); // This function manages cache coherency for BDs
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to pass buffer descriptor ring to the hardware. \n\r");
		return -1;
	}

	Xil_DCacheFlush();

//	printf("TX:\r\n");
//	print_desc(tx_bd_ptr);
//	printf("RX:\r\n");
//	print_desc(rx_bd_ptr);

	/*
	 * 4. SEND IT
	 */
	status = XAxiDma_BdRingStart(tx_ring);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to kick off S2MM transfer.\n\r");
		return -1;
	}

	status = XAxiDma_BdRingStart(rx_ring);
	if (status != XST_SUCCESS)
	{
		xil_printf("ERROR! Failed to kick off S2MM transfer.\n\r");
		return -1;
	}

	sleep(5);

	Xil_DCacheFlush();

	XAxiDma_DumpBd(tx_bd_ptr);
	XAxiDma_DumpBd(rx_bd_ptr);

	volatile unsigned int * ptr = AxiDma.RegBase;
	printf("MM2S_DMASR: %x\r\n", ptr[1]);
	printf("S2MM_DMASR: %x\r\n", ptr[13]);


	for (i = 0; i < SIZE; i++) {
		printf("%x ", grid[i]);
	}

	printf("\r\n\r\n");

	for (i = 0; i < SIZE; i++) {
		printf("%x ", grid_out[i]);
	}

	printf("\r\n");

	// VIEDO STFUD

//
//    XVtc Vtc;
//	XVtc_Config *VtcCfgPtr;
//
//	int i, j;
//
//	print("Hello, World!\r\n");
//
//
//	// Enable the VTC module
//	print("XVtc_LookupConfig\r\n");
//	VtcCfgPtr = XVtc_LookupConfig(XPAR_AXI_VDMA_0_DEVICE_ID);
//	printf("%x\r\n", (unsigned int) VtcCfgPtr->BaseAddress);
//	print("XVtc_CfgInitialize\r\n");
//	XVtc_CfgInitialize(&Vtc, VtcCfgPtr, VtcCfgPtr->BaseAddress);
//	print("XVtc_Enable\r\n");
//	XVtc_Enable(&Vtc, XVTC_EN_GENERATOR);
//
//	print("Filling frame...\r\n");
//
//	// Initialize Test image for VDMA transfer to VGA monitor
//	for (i = 2; i < 720; i++) {
//	  for (j = 2; j < 1280; j++) {
//
//		if (j < 213) {
//		  test_image[i][j] = 0x0FFF; // red pixels
//		}
//		else if(j < 426 ) {
//		  test_image[i][j] = 0x00F0; // green pixels
//		}
//		else {
//		  test_image[i][j] = 0x0F00; // blue pixels
//		}
//
//	  }
//	}
//
//	Xil_DCacheFlush();
//
//	// Set up VDMA config registers
//	#define CHANGE_ME 0
//
//	print("Configuring VDMA...\r\n");
//
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_CR_OFFSET,  0x03);  // Circular Mode and Start bits set, VDMA MM2S Control (p. 34)
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_HI_FRMBUF_OFFSET, 0x00);  // VDMA MM2S Reg_Index (P. 44)
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_FRMSTORE_OFFSET, 0x01);  // VDMA MM2S Number FRM_Stores (p. 45)
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_START_ADDR_OFFSET, test_image);  // VDMA MM2S Start Addr 1
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_STRD_FRMDLY_OFFSET, 1280);  // 1280 bytes, VDMA MM2S FRM_Delay, and Stride
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_HSIZE_OFFSET, 1280);  // 1280 bytes, VDMA MM2S HSIZE
//	XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_VSIZE_OFFSET, 480);  // 480 lines, VDMA MM2S VSIZE  (Note: Starts VDMA transaction
//
//	print("Something should be happening!\r\n");
//
//	while(1) {
//
//	}
//
//    xil_printf("---------[END]---------\n\r");
    return 0;
}
