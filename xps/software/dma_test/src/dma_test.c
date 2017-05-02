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
#include <xparameters.h>
#include "platform.h"
#include "axi_dma_ftw.h"

#define OFFSET(TY,FIELD) (&((TY *) 0)->FIELD)
#define ALIGN(some_ptr, boundary) (int*)(some_ptr + boundary-some_ptr%boundary)
#define ALIGN64(some_ptr) ALIGN(some_ptr, 0x40)
#define ALIGN4(some_ptr) ALIGN(some_ptr, 0x4)


void print_offsets() {
	printf("----- Register offsets -----\n");
	printf("mm2s_dmacr: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, mm2s_dmacr));
	printf("mm2s_dmasr: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, mm2s_dmasr));
	printf("mm2s_curdesc: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, mm2s_curdesc));
	printf("mm2s_taildesc: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, mm2s_taildesc));
	printf("sg_ctl: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, sg_ctl));
	printf("s2mm_dmacr: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, s2mm_dmacr));
	printf("s2mm_dmasr: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, s2mm_dmasr));
	printf("s2mm_curdesc: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, s2mm_curdesc));
	printf("s2mm_taildesc: %x\n", (uint) OFFSET(AXI_DMA_SG_REGMAP, s2mm_taildesc));
	printf("----------------------------\n");

	printf("----- Descriptor offsets -----\n");
	printf("next_ptr: %x\n", (uint) OFFSET(DMA_SG_DESC, next_ptr));
	printf("buffer_address: %x\n", (uint) OFFSET(DMA_SG_DESC, buffer_address));
	printf("control: %x\n", (uint) OFFSET(DMA_SG_DESC, control));
	printf("status: %x\n", (uint) OFFSET(DMA_SG_DESC, status));
	printf("----------------------------\n");
}

void print_desc(PDMA_SG_DESC desc) {
	unsigned char * ptr = (unsigned char *) desc;
	int i;
	for (i = 0; i < 16; i++) {
		printf("%02x %02x %02x %02x \r\n", ptr[i*4+3], ptr[i*4+2], ptr[i*4+1], ptr[i*4]);
	}
}

#define SIZE 32


int main() {
    int i, j;

    print_offsets();

    volatile PAXI_DMA_SG_REGMAP dma_dev = (PAXI_DMA_SG_REGMAP) XPAR_AXI_DMA_0_BASEADDR;

    dma_dev->mm2s_dmacr.as_uint = 0;
    dma_dev->s2mm_dmacr.as_uint = 0;

    dma_dev->mm2s_dmacr.reset = 1;
    dma_dev->s2mm_dmacr.reset = 1;

    printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
    printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);


    volatile uint32_t * arr_from = (uint32_t *) malloc(SIZE*sizeof(uint32_t));

    volatile uint32_t * arr_to = (uint32_t *) malloc(SIZE*sizeof(uint32_t));

    for (i = 0; i < SIZE; i++) {
		arr_from[i] = 0x00FF00CC;
    }

    memset(arr_to, 0x55, SIZE*sizeof(uint32_t));

    for (i = 0; i < SIZE; i++) {
		printf("%x ", arr_from[i]);
    }

    printf("\r\n");

    for (i = 0; i < SIZE; i++) {
		printf("%x ", arr_to[i]);
	}

	printf("\r\n");
    printf("arr_from: %x \r\n", (uint32_t) arr_from);
	printf("arr_to: %x \r\n", (uint32_t) arr_to);

	printf("sizeof(DMA_SG_DESC) = %d \r\n", sizeof(DMA_SG_DESC));

    // Setup Tx packet descriptor
    volatile PDMA_SG_DESC tx0 = (PDMA_SG_DESC) malloc(sizeof(DMA_SG_DESC) + 0x40);
    tx0 = ALIGN64((uint32_t)tx0);
    memset(tx0, 0x00, sizeof(DMA_SG_DESC));
    tx0->next_ptr = (uint32_t) tx0;
    tx0->buffer_address = (uint32_t)arr_from;
    tx0->control.buffer_length = SIZE*sizeof(uint32_t);
    tx0->control.tx_sof = 1;
    tx0->control.tx_eof = 1;
    //tx0->reserved6 = 0x0104;

    // Setup Rx descriptor
    volatile PDMA_SG_DESC rx0 = (PDMA_SG_DESC) malloc(sizeof(DMA_SG_DESC) + 0x40);
    rx0 = ALIGN64((uint32_t)rx0);
    memset(rx0, 0x00, sizeof(DMA_SG_DESC));
    rx0->next_ptr = (uint32_t)rx0;
    rx0->buffer_address = (uint32_t)arr_to;
    rx0->control.buffer_length = SIZE*sizeof(uint32_t);
    //rx0->reserved6 = 0x0104;

    Xil_DCacheFlushRange(tx0, 0x40);
    Xil_DCacheFlushRange(rx0, 0x40);

    printf("TX:\r\n");
	print_desc(tx0);
	printf("RX:\r\n");
	print_desc(rx0);

    // Let the DMA engine run
    printf("Releaseing reset... \r\n");
    dma_dev->mm2s_dmacr.reset = 0;
    dma_dev->s2mm_dmacr.reset = 0;
    dma_dev->mm2s_dmacr.as_uint = 0;
	dma_dev->s2mm_dmacr.as_uint = 0;
    printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
	printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);


	// Start the TX
	printf("Start TX... \r\n");
	dma_dev->mm2s_curdesc = (uint32_t)tx0;
	dma_dev->mm2s_dmacr.run_stop = 1;
	dma_dev->mm2s_taildesc = (uint32_t)tx0;

	// Start the RX
	printf("Start RX... \r\n");
	dma_dev->s2mm_curdesc = (uint32_t)rx0;
	dma_dev->s2mm_dmacr.run_stop = 1;
	dma_dev->s2mm_taildesc = (uint32_t)rx0;



	printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
	printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);

    Xil_DCacheFlush();

    // Wait for the DMA to complete
    while (!dma_dev->mm2s_dmasr.idle || !dma_dev->s2mm_dmasr.idle) {
    	sleep(2);
    	printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
		printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);
		printf("Tx Status: %x \r\n", tx0->status.as_uint);
		printf("Rx Status: %x \r\n", rx0->status.as_uint);
    	Xil_DCacheFlushRange(dma_dev, sizeof(*dma_dev));
    }

	Xil_DCacheFlush();
	Xil_DCacheInvalidateRange(arr_from, SIZE*sizeof(uint32_t));
	Xil_DCacheInvalidateRange(arr_to, SIZE*sizeof(uint32_t));
	sleep(2);
	printf("----------------------------------\r\n");
	printf("DMA Idle! \r\n");
	printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
	printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);
	printf("Tx Status: %x \r\n", tx0->status.as_uint);
	printf("Rx Status: %x \r\n", rx0->status.as_uint);

	// Print the result
	for (i = 0; i < SIZE; i++) {
		printf("%x ", arr_from[i]);
	}

	printf("\r\n");

	for (i = 0; i < SIZE; i++) {
		printf("%x ", arr_to[i]);
	}

	printf("\r\n");

    //while(1);

	return 0;
}
