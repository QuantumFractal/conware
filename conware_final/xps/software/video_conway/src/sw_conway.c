/*
 * sw_conway.c
 *
 *  Created on: Apr 27, 2017
 *      Author: quanta
 */
#include "sw_conway.h"

void raster_game(int x, int y, int width, int height){
	int i,j;

	int x_ratio = (int) ((GAME_WIDTH << 16) / width) + 1;
	int y_ratio = (int) ((GAME_HEIGHT << 16) / height) + 1;
	int x2, y2;

	for (i=1; i<width; i++){
		for (j=1; j<height; j++){
			x2 = ((j*x_ratio)>> 16);
			y2 = ((i*y_ratio)>>16);

			if (game_grid[x2][y2] == 1){
				test_image[x+i][y+j] = ALIVE_CELL;
			} else {
				test_image[x+i][y+j] = DEAD_CELL;
			}
		}
	}
}

void place_block(int x, int y) {
	if (x >=0 && x < GAME_WIDTH - 1){
		if (y >=0 && y < GAME_HEIGHT -1) {
			game_grid[x+0][y+1] = 1;
			game_grid[x+0][y+0] = 1;
			game_grid[x+1][y+1] = 1;
			game_grid[x+1][y+0] = 1;
		}
	}
}

void evolve(int w, int h)
{
	int x,y,x1,y1,i,j;

	for (j=0; j<GAME_HEIGHT; j++){
		for (i=0; i<GAME_WIDTH; i++){
			int nearest_sum = game_grid[i-1][j-1] + game_grid[i][j-1] + game_grid[i+1][j-1] +
					          game_grid[i-1][j]   +     0             + game_grid[i+1][j]   +
					          game_grid[i-1][j+1] + game_grid[i][j+1] + game_grid[i+1][j+1];
			int current = game_grid[i][j];
			if (current) {
				if (nearest_sum < 2){
					temp_grid[i][j] = 0;
				} else if (nearest_sum > 3){
					temp_grid[i][j] = 0;
				} else {
					temp_grid[i][j] = 1;
				}
			} else {
				if (nearest_sum == 3) {
					temp_grid[i][j] = 1;
				}
			}
		}
	}
	for (i=0; i<GAME_WIDTH; i++){
		for (j=0; j<GAME_HEIGHT; j++){
			game_grid[i][j] = temp_grid[i][j];
			temp_grid[i][j] = 0;
		}
	}
}
