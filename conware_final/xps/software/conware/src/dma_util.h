#ifndef __DMA_UTIL_
#define __DMA_UTIL_

#include xparameters.h
#include xstatus.h
#include "xaxidma.h"

void configure_DMA(XAxiDma* AxiDMA);
XAxiDma_BdRing * create_BD(XAxiDMA * AxiDMA, int num_bds, int is_tx);

#endif