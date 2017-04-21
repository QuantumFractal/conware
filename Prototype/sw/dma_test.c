#include "axi_dma_ftw.h"


int main() {
    int i, j;

    volatile PAXI_DMA_SG_REGMAP dma_dev = (PAXI_DMA_SG_REGMAP) 0x000000000; // TODO

    dma_dev->mm2s_dmacr.reset = 1;
    dma_dev->s2mm_dmacr.reset = 1;

    printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
    printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);

    uint32_t arr_from[32][32];
    uint32_t arr_to[32][32];

    memset(arr_from, 0x55, 32*32*sizeof(uint32_t));
    memset(arr_to, 0x00, 32*32*sizeof(uint32_t));

    for (i = 0; i < 32, i++) {
        for (j = 0; j < 32, j++) {
            printf("%x ", arr_to[i][j]);
        }   
        printf("\r\n");
    }

    // Setup Tx packet descriptor
    volatile PDMA_SG_DESC tx0 = (PDMA_SG_DESC) malloc(sizeof(DMA_SG_DESC));
    memset(tx0, 0x00, sizeof(DMA_SG_DESC));

    tx0->next_ptr = (uint32_t) tx0;
    tx0->buffer_address = arr_from;

    tx0->control.tdest = 0;
    tx0->control.tid = 0;
    tx0->control.tuser = 0;
    tx0->control.arcache = 0;
    tx0->control.aruser = 0;

    tx0->stride_vsize.stride = 32 * sizeof(uint32_t);
    tx0->stride_vsize.vsize = 32;

    tx0->hsize.hsize = 32 * sizeof(uint32_t);
    tx0->hsize.tx_eop = 1;
    tx0->hsize.tx_sop = 1;

    // Setup Rx descriptor
    volatile PDMA_SG_DESC rx0 = (PDMA_SG_DESC) malloc(sizeof(DMA_SG_DESC));
    memset(rx0, 0x00, sizeof(DMA_SG_DESC));

    rx0->next_ptr = rx0;
    rx0->buffer_address = arr_to;

    rx0->control.tdest = 0;
    rx0->control.tid = 0;
    rx0->control.tuser = 0;
    rx0->control.arcache = 0;
    rx0->control.aruser = 0;

    rx0->stride_vsize.stride = 32 * sizeof(uint32_t);
    rx0->stride_vsize.vsize = 32;

    rx0->hsize.hsize = 32 * sizeof(uint32_t);

    // Let the DMA engine run
    dma_dev->mm2s_dmacr.reset = 0;
    dma_dev->s2mm_dmacr.reset = 0;

    // Start the TX
    dma_dev->mm2s_curdesc = tx0;
    dma_dev->mm2s_dmacr.run_stop = 1;
    dma_dev->mm2s_taildesc = tx0;

    // Start the RX
    dma_dev->s2mm_curdesc = rx0;
    dma_dev->s2mm_dmacr.run_stop = 1;
    dma_dev->s2mm_taildesc = rx0;

    // Wait for the DMA to complete
    while (!dma_dev->mm2s_dmasr.halted);
    while (!dma_dev->s2mm_dmasr.halted);

    printf("Tx Status: %x \r\n", tx0->mc_sts.as_uint);
    printf("Rx Status: %x \r\n", rx0->mc_sts.as_uint);

    // Print the result
    for (i = 0; i < 32, i++) {
        for (j = 0; j < 32, j++) {
            printf("%x ", arr_to[i][j]);
        }   
        printf("\r\n");
    }

}