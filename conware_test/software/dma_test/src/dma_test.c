#include <stdio.h>
#include "xparameters.h"
#include "platform.h"
#include "axi_dma_ftw.h"

#define OFFSET(TY,FIELD) (&((TY *) 0)->FIELD)
#define SIZE 8
#define NUM_DESC 3

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

void print_arr(uint32_t * arr) {
	int i;
    for (i = 0; i < SIZE; i++) {
    	if (arr[i] == 0x55555555) printf("x ");
    	else printf("%d ", arr[i]==0xffffffff?1:0);
    }
    printf("\r\n");
}

int main() {
    int i, j;

    Xil_DCacheDisable();  // < Magic

    volatile PAXI_DMA_SG_REGMAP dma_dev = (PAXI_DMA_SG_REGMAP) 0x40400000;

    AxiDmaReset(dma_dev);
    //AxiDmaDisableIrqs(dma_dev);

    uint32_t * arr_from1 = (uint32_t *) malloc(SIZE*sizeof(uint32_t));
    uint32_t * arr_from2 = (uint32_t *) malloc(SIZE*sizeof(uint32_t));
    uint32_t * arr_from3 = (uint32_t *) malloc(SIZE*sizeof(uint32_t));

    uint32_t * arr_to1 = (uint32_t *) malloc(SIZE*sizeof(uint32_t));
    uint32_t * arr_to2 = (uint32_t *) malloc(SIZE*sizeof(uint32_t));
    uint32_t * arr_to3 = (uint32_t *) malloc(SIZE*sizeof(uint32_t));

//    for (i = 0; i < SIZE; i++) {
//        arr_from1[i] = i%2?0xFFFFFFFF:0x00000000;
//        arr_from2[i] = i%2?0x00000000:0xFFFFFFFF;
//        arr_from3[i] = 0xFFFFFFFF;
//    }

    memset(arr_from1, 0x00, SIZE*sizeof(uint32_t));
    arr_from1[2] = 0xFFFFFFFF;

    memset(arr_to1, 0x55, SIZE*sizeof(uint32_t));
    memset(arr_to2, 0x55, SIZE*sizeof(uint32_t));
    memset(arr_to3, 0x55, SIZE*sizeof(uint32_t));


    print_arr(arr_from1);
    print_arr(arr_from2);
    print_arr(arr_from3);
    print_arr(arr_to1);
    print_arr(arr_to2);
    print_arr(arr_to3);


    volatile PDMA_SG_DESC txl = AxiDmaAllocateDescList(NUM_DESC);
    AxiDmaLinkContiguousDescList(txl, NUM_DESC);
    txl[0].buffer_address = (uint32_t)arr_from1;
    txl[0].control.buffer_length = SIZE*sizeof(uint32_t);
    txl[0].control.tx_sof = 1;
    txl[0].control.tx_eof = 0;

    txl[1].buffer_address = (uint32_t)arr_from1;
    txl[1].control.buffer_length = SIZE*sizeof(uint32_t);
    txl[1].control.tx_sof = 0;
    txl[1].control.tx_eof = 0;

    txl[2].buffer_address = (uint32_t)arr_from1;
	txl[2].control.buffer_length = SIZE*sizeof(uint32_t);
	txl[2].control.tx_sof = 0;
	txl[2].control.tx_eof = 1;

    volatile PDMA_SG_DESC rxl = AxiDmaAllocateDescList(NUM_DESC);
    AxiDmaLinkContiguousDescList(rxl, NUM_DESC);
    rxl[0].buffer_address = (uint32_t)arr_to1;
    rxl[0].control.buffer_length = SIZE*sizeof(uint32_t);

    rxl[1].buffer_address = (uint32_t)arr_to2;
	rxl[1].control.buffer_length = SIZE*sizeof(uint32_t);

	rxl[2].buffer_address = (uint32_t)arr_to3;
	rxl[2].control.buffer_length = SIZE*sizeof(uint32_t);


    Xil_DCacheFlushRange(txl, 0x40);
    Xil_DCacheFlushRange(rxl, 0x40);

    //print_conware_ctl();

    AxiDmaStartTx(dma_dev, &txl[0], &txl[NUM_DESC-1]);
    AxiDmaStartRx(dma_dev, &rxl[0], &rxl[NUM_DESC-1]);

    // Wait for the DMA to complete
    AxiDmaWaitForIdle(dma_dev);

    printf("----------------------------------\r\n");
    printf("DMA Idle! \r\n");
    printf("mm2s_dmasr: %x \r\n", dma_dev->mm2s_dmasr.as_uint);
    printf("s2mm_dmasr: %x \r\n", dma_dev->s2mm_dmasr.as_uint);

    for (i = 0; i < NUM_DESC; i++) {
    	printf("Tx[%d] Status: %x \r\n", i, txl[i].status.as_uint);
    }

    for (i = 0; i < NUM_DESC; i++) {
		printf("Rx[%d] Status: %x \r\n", i, rxl[i].status.as_uint);
	}

    // Print the result
    print_arr(arr_from1);
    print_arr(arr_from2);
    print_arr(arr_from3);
    printf("\r\n");
    print_arr(arr_to1);
    print_arr(arr_to2);
    print_arr(arr_to3);

    sleep(1);
    print_conware_ctl();

    //while(1);

    return 0;
}
