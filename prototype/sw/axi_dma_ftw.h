

typedef unsigned int uint32_t;

// Registers from https://www.xilinx.com/support/documentation/ip_documentation/axi_dma/v6_03_a/pg021_axi_dma.pdf

typedef struct {
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
} DMACR, *PDMACR;

typedef struct {
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
} DMASR, *PDMASR;

typedef struct {
    uint32_t reserved0    : 6;
    uint32_t cur_desc_ptr : 26;
} CURDESC, *PCURDESC;

typedef struct {
    uint32_t reserved0     : 6;
    uint32_t tail_desc_ptr : 26;
} TAILDESC, *PTAILDESC;

typedef struct {
    uint32_t sg_cache  : 4;
    uint32_t reserved0 : 4;
    uint32_t sg_user   : 4;
    uint32_t reserved1 : 20;
} SG_CTL, *PSG_CTL;

typedef struct {

}

typedef struct {
    DMACR mm2s_dmacr;
    DMASR mm2s_dmasr;
    CURDESC mm2s_curdesc;
    uint32_t reserved0;
    TAILDESC mm2s_taildesc;
    uint32_t reserved1[6];
    SG_CTL sg_ctl;
    DMACR s2mm_dmacr;
    DMASR s2mm_dmasr;
    CURDESC s2mm_curdesc;
    uint32_t reserved2;
    TAILDESC s2mm_taildesc;
} AXI_DMA_SG_REGMAP;

typedef struct {
    uint32_t next_ptr;
    uint32_t reserved0;
    uint32_t buffer_address;
    uint32_t reserved1;

    union {
        struct {
            // TODO: These might be inverted
            uint32_t tdest     : 5;
            uint32_t reserved0 : 3;
            uint32_t tid       : 5;
            uint32_t reserved1 : 3;
            uint32_t tuser     : 4;
            uint32_t reserved2 : 4;
            uint32_t arcache   : 4;
            uint32_t aruser    : 4;
        };

        uint32_t as_uint;
    } control;

    struct {
        uint32_t stride : 16;

    };

} DMA_SG_DESC, *PDMA_SG_DESC;