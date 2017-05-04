
#include "axi_dma_ftw.h"

#define DEBUG(msg)
//#define DEBUG(msg) printf(msg); printf("\r\n");


void AxiDmaReset(volatile PAXI_DMA_SG_REGMAP dma_dev) {
	DEBUG("AxiDmaReset");

    dma_dev->mm2s_dmacr.as_uint = 0;
    dma_dev->s2mm_dmacr.as_uint = 0;

    dma_dev->mm2s_dmacr.reset = 1;
    dma_dev->s2mm_dmacr.reset = 1;

    while(dma_dev->mm2s_dmacr.reset);
    while(dma_dev->s2mm_dmacr.reset);
}

void AxiDmaDisableIrqs(volatile PAXI_DMA_SG_REGMAP dma_dev) {
	DEBUG("AxiDmaDisableIrqs");

    dma_dev->mm2s_dmacr.dly_irqen = 0;
    dma_dev->mm2s_dmacr.err_irqen = 0;
    dma_dev->mm2s_dmacr.ioc_irqen = 0;

    dma_dev->s2mm_dmacr.dly_irqen = 0;
    dma_dev->s2mm_dmacr.err_irqen = 0;
    dma_dev->s2mm_dmacr.ioc_irqen = 0;
}

PDMA_SG_DESC AxiDmaAllocateDescList(uint32_t num_desc) {
	DEBUG("AxiDmaAllocateDescList");

	PDMA_SG_DESC block = (PDMA_SG_DESC) malloc((num_desc+1) * sizeof(DMA_SG_DESC));
	memset(block, 0x00, (num_desc+1) * sizeof(DMA_SG_DESC));
	return (PDMA_SG_DESC) ALIGN64((uint32_t)block);
}

void AxiDmaLinkContiguousDescList(PDMA_SG_DESC start, uint32_t length) {
	DEBUG("AxiDmaLinkContiguousDescList");

	int i;
	PDMA_SG_DESC cur = start;
	PDMA_SG_DESC next = &cur[1];

	for (i = 0; i < length-1; i++) {
		cur->next_ptr = (uint32_t)next;
		cur = next;
		next = &cur[1];
	}

	cur->next_ptr = (uint32_t)start;
}

void AxiDmaStartTx(PAXI_DMA_SG_REGMAP dma_dev, PDMA_SG_DESC start, PDMA_SG_DESC end) {
	DEBUG("AxiDmaStartTx");

    dma_dev->mm2s_curdesc = (uint32_t)start;
    dma_dev->mm2s_dmacr.run_stop = 1;
    dma_dev->mm2s_taildesc = (uint32_t)end;
}

void AxiDmaStartRx(PAXI_DMA_SG_REGMAP dma_dev, PDMA_SG_DESC start, PDMA_SG_DESC end) {
	DEBUG("AxiDmaStartRx");
    dma_dev->s2mm_curdesc = (uint32_t)start;
    dma_dev->s2mm_dmacr.run_stop = 1;
    dma_dev->s2mm_taildesc = (uint32_t)end;
}

void AxiDmaWaitForIdle(PAXI_DMA_SG_REGMAP dma_dev) {
	DEBUG("AxiDmaWaitForIdle");
	while (!dma_dev->mm2s_dmasr.idle || !dma_dev->s2mm_dmasr.idle) {
		Xil_DCacheFlushRange(dma_dev, sizeof(*dma_dev));
	}
}

void AxiDmaDumpDescHex(PDMA_SG_DESC desc) {
	DEBUG("AxiDmaDumpDescHex");

	printf("PDMA_SG_DESC @ %x: \r\n", desc);

    unsigned char * ptr = (unsigned char *) desc;
    int i;
    for (i = 0; i < 16; i++) {
        printf("%02x %02x %02x %02x \r\n", ptr[i*4+3], ptr[i*4+2], ptr[i*4+1], ptr[i*4]);
    }
}
