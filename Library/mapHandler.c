#include "mapHandler.h"
#include "myLib.h"

unsigned short SCREEN_MAP[1024];		// the map we'll draw to the screen
unsigned short WORLD_TILES[8000];		// all the tiles in our current area
unsigned short WORLD_MAP[3500];			// the entire map of our current area
unsigned short WORLD_TILE_LENGTH;		// length of area tiles
unsigned short WORLD_MAP_LENGTH;		// length of area map
unsigned short WORLD_MAP_TILE_WIDTH;	// how many tiles wide our area map is
unsigned short WORLD_MAP_TILE_HEIGHT;	// how many tiles tall our area map is
int TILE_COL;							// our current leftmost col position on the area map
int TILE_ROW;							// our current topmost row position on the area map
int COL_CURSOR;					// how many column tiles we've moved since first drawing the map
int ROW_CURSOR;					// how many row tiles we've moved since first drawing the map

char moving;

// Use this when entering a new area to load the area's tiles & map
void loadMap(const unsigned short* tiles, const unsigned short tlen, 	// tiles of new area
				const unsigned short* map, const unsigned short mlen,   // map of new area
				unsigned short tilew, unsigned short tileh) {			// width and height of area in 8x8 tiles

	WORLD_TILE_LENGTH = tlen;
	WORLD_MAP_LENGTH = mlen;
	WORLD_MAP_TILE_WIDTH = tilew;
	WORLD_MAP_TILE_HEIGHT = tileh;
	DMANow(3, tiles, WORLD_TILES, tlen/2); 
	DMANow(3, map, WORLD_MAP, mlen/2);

	moving = 0;
	// Now we can use the generic WORLD_TILES and WORLD_MAP to draw everything

}

// Use this when entering a new area to draw the intial map at the player's location
void initMap(int r, int c) {
	// make a 256x256 map with r and c being the top left tile
	// NOTE: r and c are 'tile' positions, not 'pixel' positions (1 tile = 8 pixels)
	for (int i = 0; i < 32; i++) {
		DMANow(3, &WORLD_MAP[OFFSET(i + r, 0 + c, WORLD_MAP_TILE_WIDTH)], &SCREEN_MAP[OFFSET(i, 0, 32)], 32);
	}
	TILE_ROW = r;
	TILE_COL = c;
	ROW_CURSOR = 0;
	COL_CURSOR = 0;
}

// draw 2 cols worth of tiles to appear on the left
void moveMapLeft() {

	for (int x = 0; x <= 1; x++) {
		COL_CURSOR -= 1;
		TILE_COL -= 1;

		int temp_col_cursor = COL_CURSOR;

		if (COL_CURSOR < 0) {
			temp_col_cursor = COL_CURSOR + 32;
		}
		if (COL_CURSOR >= 32) {
			temp_col_cursor = COL_CURSOR - 32;
		}

		for (int i = 0; i < 32; i++) {
			SCREEN_MAP[OFFSET(i, temp_col_cursor, 32)] = WORLD_MAP[OFFSET(i, TILE_COL, WORLD_MAP_TILE_WIDTH)];
		}
	}

	DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[31], WORLD_MAP_LENGTH/2);
}

// draws 2 cols worth of tiles to appear on the right
void moveMapRight() {

	for (int x = 1; x >= 0; x--) {
		COL_CURSOR += 1;
		TILE_COL += 1;

		int temp_col_cursor = COL_CURSOR;

		if (COL_CURSOR < 0) {
			temp_col_cursor = COL_CURSOR + 32;
		}
		if (COL_CURSOR > 32) {
			temp_col_cursor = COL_CURSOR - 32;
		}

		for (int i = 0; i < 32; i++) {
			SCREEN_MAP[OFFSET(i, temp_col_cursor - 1, 32)] = WORLD_MAP[OFFSET(i, SCREEN_TILE_WIDTH + TILE_COL + 1, WORLD_MAP_TILE_WIDTH)];
		}
	}

	DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[31], WORLD_MAP_LENGTH/2);
	
}

void moveMapUp() {

	for (int x = 0; x <= 1; x++) {
		
		TILE_ROW -= 1;
		ROW_CURSOR -= 1;
		

		int temp_row_cursor = ROW_CURSOR;

		if (ROW_CURSOR < 0) {
			temp_row_cursor = 32 + ROW_CURSOR;
		}


			
			for (int i = 0; i < 32; i++) {
				SCREEN_MAP[OFFSET(temp_row_cursor, i, 32)] = WORLD_MAP[OFFSET(TILE_ROW, i, WORLD_MAP_TILE_WIDTH)];
			}
		
		
	}

	DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[31], WORLD_MAP_LENGTH/2);

}

void moveMapDown() {

	// > 15 stop drawing

	for (int x = 1; x >= 0; x--) {

		TILE_ROW += 1;
		ROW_CURSOR += 1;

		int temp_row_cursor = ROW_CURSOR;

		if (ROW_CURSOR < 0) {
			temp_row_cursor = ROW_CURSOR + 32;
		}
		if (ROW_CURSOR > 32) {
			temp_row_cursor = ROW_CURSOR - 32;
		}

		if (TILE_ROW < WORLD_MAP_TILE_HEIGHT - 32 + 1) {

			

			for (int i = 0; i < 32; i++) {
				//SCREEN_MAP[OFFSET(SCREEN_TILE_HEIGHT + temp_row_offset - 1, i, 32)] = WORLD_MAP[OFFSET(SCREEN_TILE_HEIGHT + TILE_ROW - 1, i + TILE_COL, WORLD_MAP_TILE_WIDTH)];
				SCREEN_MAP[OFFSET(temp_row_cursor - 1, i, 32)] = WORLD_MAP[OFFSET(32 + TILE_ROW - 1, i, WORLD_MAP_TILE_WIDTH)];
			}
		}

	}

	DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[31], WORLD_MAP_LENGTH/2);
	
}