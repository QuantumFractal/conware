
#ifndef __AXI_DMA_FTW
#define __AXI_DMA_FTW

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
    uint32_t reserved0    : 6;
    uint32_t cur_desc_ptr : 26;
} CURDESC, *PCURDESC;

typedef struct __attribute__((packed)) {
    uint32_t reserved0     : 6;
    uint32_t tail_desc_ptr : 26;
} TAILDESC, *PTAILDESC;

typedef struct __attribute__((packed)) {
    uint32_t sg_cache  : 4;
    uint32_t reserved0 : 4;
    uint32_t sg_user   : 4;
    uint32_t reserved1 : 20;
} SG_CTL, *PSG_CTL;

typedef struct __attribute__((packed)) {
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
} AXI_DMA_SG_REGMAP, *PAXI_DMA_SG_REGMAP;

typedef struct __attribute__((packed)) {
    uint32_t next_ptr;
    uint32_t reserved0;
    uint32_t buffer_address;
    uint32_t reserved1;

    union __attribute__((packed)) {
        struct __attribute__((packed)) {
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

    union __attribute__((packed)) {
        struct __attribute__((packed)) {
            uint32_t stride : 16;
            uint32_t reserved0 : 3;
            uint32_t vsize : 13;
        };

        uint32_t as_uint;
    } stride_vsize;

    union __attribute__((packed)) {
        struct __attribute__((packed)) {
            uint32_t hsize : 16;
            uint32_t reserved0 : 10;
            uint32_t tx_eop : 1;
            uint32_t tx_sop : 1;
            uint32_t reserved1 : 4;
        };

        uint32_t as_uint;
    } hsize;

    union __attribute__((packed)) {
        struct __attribute__((packed)) {
            uint32_t tdest : 5;
            uint32_t reserved0 : 3;
            uint32_t tid : 5;
            uint32_t reserved1 : 3;
            uint32_t tuser : 4;
            uint32_t reserved2 : 6;
            uint32_t rx_eop : 1;
            uint32_t rx_sop : 1;
            uint32_t ie : 1;
            uint32_t se : 1;
            uint32_t de : 1;
            uint32_t cmp : 1;
        };

        uint32_t as_uint;
    } mc_sts;

    uint32_t app0;
    uint32_t app1;
    uint32_t app2;
    uint32_t app3;
    uint32_t app4;

    uint32_t reserved2;
    uint32_t reserved3;
    uint32_t reserved4;

} DMA_SG_DESC, *PDMA_SG_DESC;




#endif
