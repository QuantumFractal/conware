

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
    } mc_ctl;

    struct {
        uint32_t stride : 16;

    };

} MM2S_TX_DESC, *PMM2S_TX_DESC;