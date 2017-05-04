
#ifndef __AXI_DMA_FTW
#define __AXI_DMA_FTW

#define ALIGN(some_ptr, boundary) (int*)(some_ptr + boundary-some_ptr%boundary)
#define ALIGN64(some_ptr) ALIGN(some_ptr, 0x40)
#define ALIGN4(some_ptr) ALIGN(some_ptr, 0x4)

typedef unsigned int uint32_t;

// Registers from https://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v6_03_a/pg021_axi_dma.pdf

typedef union __attribute__((packed)) {
    struct __attribute__((packed)) {
        uint32_t run_stop      : 1;
        uint32_t reserved0     : 1;
        uint32_t reset         : 1;
        uint32_t keyhole       : 1;
        uint32_t reserved1     : 8;
        uint32_t ioc_irqen     : 1;
        uint32_t dly_irqen     : 1;
        uint32_t err_irqen     : 1;
        uint32_t reserved2     : 1;
        uint32_t irq_threshold : 8;
        uint32_t irq_delay     : 8;
    };

    uint32_t as_uint;
} DMACR, *PDMACR;

typedef union __attribute__((packed)) {
    struct __attribute__((packed)) {
        uint32_t halted            : 1;
        uint32_t idle              : 1;
        uint32_t reserved0         : 1;
        uint32_t sgincid           : 1;

        uint32_t dma_int_err       : 1;
        uint32_t dma_slv_err       : 1;
        uint32_t dma_dec_err       : 1;
        uint32_t reserved1         : 1;

        uint32_t sg_int_err        : 1;
        uint32_t sg_slv_err        : 1;
        uint32_t sg_dec_err        : 1;
        uint32_t reserved2         : 1;

        uint32_t ioc_irq           : 1;
        uint32_t dly_irq           : 1;
        uint32_t err_irq           : 1;
        uint32_t reserved3         : 1;

        uint32_t irq_threshold_sts : 8;
        uint32_t irq_delay_sts     : 8;
    };

    uint32_t as_uint;
} DMASR, *PDMASR;

typedef struct __attribute__((packed)) {
    uint32_t sg_cache  : 4;
    uint32_t reserved0 : 4;
    uint32_t sg_user   : 4;
    uint32_t reserved1 : 20;
} SG_CTL, *PSG_CTL;

typedef struct __attribute__((packed)) {
    DMACR mm2s_dmacr;
    DMASR mm2s_dmasr;
    uint32_t mm2s_curdesc;
    uint32_t reserved0;
    uint32_t mm2s_taildesc;
    uint32_t reserved1[6];
    SG_CTL sg_ctl;
    DMACR s2mm_dmacr;
    DMASR s2mm_dmasr;
    uint32_t s2mm_curdesc;
    uint32_t reserved2;
    uint32_t s2mm_taildesc;
} AXI_DMA_SG_REGMAP, *PAXI_DMA_SG_REGMAP;

typedef struct __attribute__((packed)) {
    uint32_t next_ptr;
    uint32_t reserved0;
    uint32_t buffer_address;
    uint32_t reserved1;
    uint32_t reserved2;
    uint32_t reserved3;

    union __attribute__((packed)) {
        struct __attribute__((packed)) {
            // TODO: These might be inverted
            uint32_t buffer_length : 23;
            uint32_t reserved0     : 3;
            uint32_t tx_eof        : 1;
            uint32_t tx_sof        : 1;
            uint32_t reserved1     : 4;
        };

        uint32_t as_uint;
    } control;

    union __attribute__((packed)) {
        struct __attribute__((packed)) {
            uint32_t transferred_bytes : 23;
            uint32_t reserved0         : 5;
            uint32_t int_err           : 1;
            uint32_t slv_err           : 1;
            uint32_t dec_err           : 1;
            uint32_t cmplt             : 1;
        };

        uint32_t as_uint;
    } status;

    uint32_t app0;
    uint32_t app1;
    uint32_t app2;
    uint32_t app3;
    uint32_t app4;


    uint32_t reserved4;
    uint32_t reserved5;
    uint32_t reserved6;

} DMA_SG_DESC, *PDMA_SG_DESC;


void AxiDmaReset(volatile PAXI_DMA_SG_REGMAP dma_dev);
void AxiDmaDisableIrqs(volatile PAXI_DMA_SG_REGMAP dma_dev);

volatile PDMA_SG_DESC AxiDmaAllocateDescList(uint32_t num_desc);
void AxiDmaLinkContiguousDescList(PDMA_SG_DESC start, uint32_t length);

void AxiDmaStartTx(volatile PAXI_DMA_SG_REGMAP dma_dev, PDMA_SG_DESC start, PDMA_SG_DESC end);
void AxiDmaStartRx(volatile PAXI_DMA_SG_REGMAP dma_dev, PDMA_SG_DESC start, PDMA_SG_DESC end);

void AxiDmaWaitForIdle(volatile PAXI_DMA_SG_REGMAP dma_dev);

void AxiDmaDumpDescHex(PDMA_SG_DESC desc);

#endif
