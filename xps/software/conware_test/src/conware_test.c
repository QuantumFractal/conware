

#include <stdio.h>
#include <xparameters.h>
#include "platform.h"
#include "axi_dma_ftw.h"

#define OFFSET(TY,FIELD) (&((TY *) 0)->FIELD)
#define ALIGN64(some_ptr) (int*)(some_ptr + 0x40-some_ptr%0x40)

#define WIDTH 32
#define HEIGHT 32


int main() {
    int i, j;

    volatile PAXI_DMA_SG_REGMAP dma_dev = (PAXI_DMA_SG_REGMAP) XPAR_AXI_DMA_0_BASEADDR;

    dma_dev->mm2s_dmacr.as_uint = 0;
    dma_dev->s2mm_dmacr.as_uint = 0;

    dma_dev->mm2s_dmacr.reset = 1;
    dma_dev->s2mm_dmacr.reset = 1;



    uint32_t * life0 = (uint32_t *) malloc(WIDTH*HEIGHT*sizeof(uint32_t));
    uint32_t * life1 = (uint32_t *) malloc(WIDTH*HEIGHT*sizeof(uint32_t));
    uint32_t * garbage = (uint32_t *) malloc(WIDTH*sizeof(uint32_t));

    // TODO: Setup the game here



    // Setup Tx packet descriptor
    volatile PDMA_SG_DESC tx0 = (PDMA_SG_DESC) malloc(sizeof(DMA_SG_DESC) + 0x40);
    tx0 = ALIGN64((uint32_t)tx0);
    memset(tx0, 0x00, sizeof(DMA_SG_DESC));

    tx0->next_ptr = (uint32_t) tx0;
    tx0->buffer_address = (uint32_t)arr_from;
    tx0->control.buffer_length = SIZE*SIZE*sizeof(uint32_t);
    tx0->control.tx_sof = 1;
    tx0->control.tx_eof = 1;

    // Setup Rx descriptor
    volatile PDMA_SG_DESC rx0 = (PDMA_SG_DESC) malloc(sizeof(DMA_SG_DESC) + 0x40);
    rx0 = ALIGN64((uint32_t)rx0);
    memset(rx0, 0x00, sizeof(DMA_SG_DESC));

    rx0->next_ptr = (uint32_t)rx0;
    rx0->buffer_address = (uint32_t)arr_to;
    rx0->control.buffer_length = SIZE*SIZE*sizeof(uint32_t);

    Xil_DCacheFlushRange(tx0, 0x40);
    Xil_DCacheFlushRange(rx0, 0x40);

    // Let the DMA engine run
    printf("Releaseing reset... \r\n");
    dma_dev->mm2s_dmacr.reset = 0;
    dma_dev->s2mm_dmacr.reset = 0;
    printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
	printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);

	// Start the RX
	printf("Start RX... \r\n");
	dma_dev->s2mm_curdesc = (uint32_t)rx0;
	dma_dev->s2mm_dmacr.run_stop = 1;
	dma_dev->s2mm_taildesc = (uint32_t)rx0;

	// Start the TX
	printf("Start TX... \r\n");
	dma_dev->mm2s_curdesc = (uint32_t)tx0;
	dma_dev->mm2s_dmacr.run_stop = 1;
	dma_dev->mm2s_taildesc = (uint32_t)tx0;



	printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
	printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);

    Xil_DCacheFlush();

    // Wait for the DMA to complete
    while (!dma_dev->mm2s_dmasr.idle || !dma_dev->s2mm_dmasr.idle) {
    	Xil_DCacheFlushRange(dma_dev, sizeof(*dma_dev));
    }

    Xil_DCacheFlush();

    printf("DMA Idle! \r\n");
    printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
	printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);
    printf("Tx Status: %x \r\n", tx0->status.as_uint);
    printf("Rx Status: %x \r\n", rx0->status.as_uint);

    // Print the result
    for (i = 0; i < SIZE; i++) {
        for (j = 0; j < SIZE; j++) {
            printf("%c ", (char)arr_to[i* SIZE + j]);
        }
        printf("\r\n");
    }

    while(1);

	return 0;
}
