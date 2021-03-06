#include <stdio.h>
#include "xparameters.h"
#include "platform.h"
#include "axi_dma_ftw.h"

#define OFFSET(TY,FIELD) (&((TY *) 0)->FIELD)
#define GAMESIZE 8
#define NUMPAD 2

typedef struct __attribute__((packed)) {
	uint32_t reserved0;

	union __attribute__((packed)) {
		struct {
			uint32_t write_ctr : 8;
			uint32_t read_ctr : 8;
			uint32_t out_states : 8;
			uint32_t in_states : 8;
		};
		uint32_t as_uint;
	} state_ctr;

	uint32_t num_reads;
	uint32_t num_writes;

} conware_ctl_regmap;

void print_conware_ctl() {
	conware_ctl_regmap * ptr = 0x74400000;

	printf("-------------------\r\n");
	printf("write_ctr: %d \r\n", ptr->state_ctr.write_ctr);
	printf("read_ctr: %d \r\n", ptr->state_ctr.read_ctr);
	printf("out_states: %x \r\n", ptr->state_ctr.out_states);
	printf("in_states: %x \r\n", ptr->state_ctr.in_states);

	printf("num_reads: %u \r\n", ptr->num_reads);
	printf("num_writes: %u \r\n", ptr->num_writes);

}

inline int to_index(int row, int col) {
	return row * GAMESIZE + col;
}

void print_game(uint32_t * arr) {
	int i, j;
    for (i = 0; i < GAMESIZE; i++) {
    	for (j = 0; j < GAMESIZE; j++) {
    		if (arr[to_index(i, j)] == 0x55555555) printf("x ");
			else printf("%s ", arr[to_index(i, j)]==0xffffffff?"■":"_");
    	}
    	printf("\r\n");
    }
    printf("\r\n");
}

int main() {
    int i;

    Xil_DCacheDisable();  // < Magic

    volatile PAXI_DMA_SG_REGMAP dma_dev = (PAXI_DMA_SG_REGMAP) 0x40400000;

    AxiDmaReset(dma_dev);

    uint32_t * garbage = (uint32_t *) malloc(GAMESIZE*sizeof(uint32_t));
    uint32_t * game_in = (uint32_t *) malloc(GAMESIZE*GAMESIZE*sizeof(uint32_t));
    uint32_t * game_out = (uint32_t *) malloc(GAMESIZE*GAMESIZE*sizeof(uint32_t));

    memset(garbage, 0x00, GAMESIZE*sizeof(uint32_t));
    memset(game_in, 0x00, GAMESIZE*GAMESIZE*sizeof(uint32_t));
    memset(game_out, 0x55, GAMESIZE*GAMESIZE*sizeof(uint32_t));

    // TODO: Make a test pattern

    game_in[to_index(4, 2)] = 0xFFFFFFFF;
    game_in[to_index(3, 2)] = 0xFFFFFFFF;
    game_in[to_index(2, 2)] = 0xFFFFFFFF;
    game_in[to_index(2, 3)] = 0xFFFFFFFF;
    game_in[to_index(2, 4)] = 0xFFFFFFFF;

    print_game(game_in);
    printf("------------------------\r\n");


    volatile PDMA_SG_DESC txl = AxiDmaAllocateDescList(GAMESIZE+NUMPAD);
    AxiDmaLinkContiguousDescList(txl, GAMESIZE+NUMPAD);

    for (i = 0; i < GAMESIZE; i++) {
    	txl[i].buffer_address = (uint32_t)&game_in[i*GAMESIZE];
		txl[i].control.buffer_length = GAMESIZE*sizeof(uint32_t);
    }

    for (i = 0; i < NUMPAD; i++) {
    	txl[GAMESIZE+i].buffer_address = (uint32_t)garbage;
		txl[GAMESIZE+i].control.buffer_length = GAMESIZE*sizeof(uint32_t);
    }

    txl[0].control.tx_sof = 1;
	txl[0].control.tx_eof = 0;

	txl[GAMESIZE-1].control.tx_sof = 0;
	txl[GAMESIZE-1].control.tx_eof = 1;


    volatile PDMA_SG_DESC rxl = AxiDmaAllocateDescList(GAMESIZE+NUMPAD);
    AxiDmaLinkContiguousDescList(rxl, GAMESIZE+NUMPAD);

    for (i = 0; i < NUMPAD; i++) {
    	rxl[i].buffer_address = (uint32_t)garbage;
		rxl[i].control.buffer_length = GAMESIZE*sizeof(uint32_t);
    }

    for (i = NUMPAD; i < GAMESIZE+NUMPAD; i++) {
        rxl[i].buffer_address = (uint32_t)&game_out[(i-NUMPAD)*GAMESIZE];
        rxl[i].control.buffer_length = GAMESIZE*sizeof(uint32_t);
	}

    for (i = 0; i < 5; i++) {
    	Xil_DCacheFlushRange(txl, (GAMESIZE+NUMPAD)*sizeof(PDMA_SG_DESC));
		Xil_DCacheFlushRange(rxl, (GAMESIZE+NUMPAD)*sizeof(PDMA_SG_DESC));

		AxiDmaStartTx(dma_dev, &txl[0], &txl[GAMESIZE+NUMPAD-1]);
		AxiDmaStartRx(dma_dev, &rxl[0], &rxl[GAMESIZE+NUMPAD-1]);

		AxiDmaWaitForIdle(dma_dev);

		AxiDmaClearContiguousDescListStatus(txl, GAMESIZE+NUMPAD);
		AxiDmaClearContiguousDescListStatus(rxl, GAMESIZE+NUMPAD);

		memcpy(game_in, game_out, GAMESIZE*GAMESIZE*sizeof(uint32_t));

		print_game(game_out);
		sleep(1);
    }



    print_conware_ctl();
    return 0;
}
