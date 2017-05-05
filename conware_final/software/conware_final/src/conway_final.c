/*
 * conway_final.c
 *
 *  Created on: May 4, 2017
 *      Author: mdavies
 */



#include <stdio.h>
#include <xparameters.h>
#include "xvtc.h"
#include "xaxivdma.h"
#include "conway.h"
#include "axi_dma_ftw.h"

#define for_x for (x = 0; x < w; x++)
#define for_y for (y = 0; y < h; y++)
#define for_xy for_x for_y
#define screen_iterate for(i = 0; i < 480; i++) for (j = 1; j < 640; j++)

#define OFFSET(TY,FIELD) (&((TY *) 0)->FIELD)
#define GAMESIZE 8
#define NUMPAD 2


short test_image[480][640];
int  game_grid[GAME_HEIGHT][GAME_WIDTH];
volatile PDMA_SG_DESC txl;
volatile PDMA_SG_DESC rxl;
volatile PAXI_DMA_SG_REGMAP dma_dev;
uint32_t * game_in;
uint32_t * game_out;


void evolve_hardware() {
	Xil_DCacheDisable();
	Xil_DCacheFlushRange(txl, (GAMESIZE+NUMPAD)*sizeof(PDMA_SG_DESC));
	Xil_DCacheFlushRange(rxl, (GAMESIZE+NUMPAD)*sizeof(PDMA_SG_DESC));

	AxiDmaStartTx(dma_dev, &txl[0], &txl[GAMESIZE+NUMPAD-1]);
	AxiDmaStartRx(dma_dev, &rxl[0], &rxl[GAMESIZE+NUMPAD-1]);

	AxiDmaWaitForIdle(dma_dev);

	AxiDmaClearContiguousDescListStatus(txl, GAMESIZE+NUMPAD);
	AxiDmaClearContiguousDescListStatus(rxl, GAMESIZE+NUMPAD);

	memcpy(game_in, game_out, GAMESIZE*GAMESIZE*sizeof(uint32_t));

	//print_game(game_out);
	Xil_DCacheEnable();
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

	XVtc Vtc;
    XVtc_Config *VtcCfgPtr;
    XVtc_Signal *original;
    XVtc_HoriOffsets * offsets;

    int i, j;


    // Enable the VTC module


    screen_iterate {
    	test_image[i][j] = 0x0abc;
    }

    // Setup DMA for Hardware Accelerator
    Xil_DCacheDisable();  // < Magic

    dma_dev = (PAXI_DMA_SG_REGMAP) 0x40400000;

	AxiDmaReset(dma_dev);

	uint32_t * garbage = (uint32_t *) malloc(GAMESIZE*sizeof(uint32_t));
	game_in = (uint32_t *) malloc(GAMESIZE*GAMESIZE*sizeof(uint32_t));
	game_out = (uint32_t *) malloc(GAMESIZE*GAMESIZE*sizeof(uint32_t));

	memset(garbage, 0x00, GAMESIZE*sizeof(uint32_t));
	memset(game_in, 0x00, GAMESIZE*GAMESIZE*sizeof(uint32_t));
	memset(game_out, 0x00, GAMESIZE*GAMESIZE*sizeof(uint32_t));

	txl = AxiDmaAllocateDescList(GAMESIZE+NUMPAD);
	rxl = AxiDmaAllocateDescList(GAMESIZE+NUMPAD);

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

	AxiDmaLinkContiguousDescList(rxl, GAMESIZE+NUMPAD);

	for (i = 0; i < NUMPAD; i++) {
		rxl[i].buffer_address = (uint32_t)garbage;
		rxl[i].control.buffer_length = GAMESIZE*sizeof(uint32_t);
	}

	for (i = NUMPAD; i < GAMESIZE+NUMPAD; i++) {
		rxl[i].buffer_address = (uint32_t)&game_out[(i-NUMPAD)*GAMESIZE];
		rxl[i].control.buffer_length = GAMESIZE*sizeof(uint32_t);
	}

	//Xil_DCacheEnable();

    // Setup Game
    test_image[300][300] = 0x000F;

    game_grid[2][1] = 1;
    game_grid[2][2] = 1;
    game_grid[2][3] = 1;

    game_in[to_index(2, 1)] = 0xFFFFFFFF;
	game_in[to_index(2, 2)] = 0xFFFFFFFF;
	game_in[to_index(2, 3)] = 0xFFFFFFFF;
	//game_in[to_index(2, 3)] = 0xFFFFFFFF;
	//game_in[to_index(2, 4)] = 0xFFFFFFFF;
    Xil_DCacheFlush();


    // Configure Video
	print("XVtc_LookupConfig\r\n");
	VtcCfgPtr = XVtc_LookupConfig(XPAR_AXI_VDMA_0_DEVICE_ID);
	print("XVtc_CfgInitialize\r\n");
	XVtc_CfgInitialize(&Vtc, VtcCfgPtr, VtcCfgPtr->BaseAddress);
	print("XVtc_Enable\r\n");
	XVtc_Enable(&Vtc, XVTC_EN_GENERATOR);
    print("Configuring VDMA...\r\n");
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_CR_OFFSET,  0x03);  // Circular Mode and Start bits set, VDMA MM2S Control (p. 34)
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_HI_FRMBUF_OFFSET, 0x00);  // VDMA MM2S Reg_Index (P. 44)
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_FRMSTORE_OFFSET, 0x01);  // VDMA MM2S Number FRM_Stores (p. 45)
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_START_ADDR_OFFSET, test_image);  // VDMA MM2S Start Addr 1
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_STRD_FRMDLY_OFFSET, 1280);  // 1280 bytes, VDMA MM2S FRM_Delay, and Stride
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_HSIZE_OFFSET, 1280);  // 1280 bytes, VDMA MM2S HSIZE
    XAxiVdma_WriteReg(XPAR_AXI_VDMA_0_BASEADDR, XAXIVDMA_MM2S_ADDR_OFFSET + XAXIVDMA_VSIZE_OFFSET, 480);  // 480 lines, VDMA MM2S VSIZE  (Note: Starts VDMA transaction
    print("Something should be happening!\r\n");


    while(1){

        evolve(game_grid);
        evolve_hardware();
        raster_game(game_grid, test_image, 50, 50, 160, 160);
        raster_game(game_in, test_image, 50, 250, 160, 160);
        Xil_DCacheFlush();
        //sleep(1);

    }
    return 0;
}

