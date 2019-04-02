#include "mapHandler.h"
#include "myLib.h"

AREAMAP area;

char moving;

// Use this when entering a new area to load the area's tiles & map
void loadMap(const unsigned short* tiles, const unsigned short tlen, 	// tiles of new area
				const unsigned short* map, const unsigned short mlen,   // map of new area
				unsigned short tilew, unsigned short tileh,				// width and height of area in 8x8 tiles
				unsigned char cbb, unsigned char sbb) {			 		// where to put in videobuffer

	area.WORLD_TILE_LENGTH = tlen;
	area.WORLD_MAP_LENGTH = mlen;
	area.WORLD_MAP_TILE_WIDTH = tilew;
	area.WORLD_MAP_TILE_HEIGHT = tileh;
	area.CBB_LOC = cbb;
	area.SBB_LOC = sbb;

	DMANow(3, tiles, area.WORLD_TILES, tlen/2); 
	DMANow(3, map, area.WORLD_MAP, mlen/2);

	DMANow(3, area.WORLD_TILES, &CHARBLOCKBASE[area.CBB_LOC], area.WORLD_TILE_LENGTH/2);
	DMANow(3, area.SCREEN_MAP, &SCREENBLOCKBASE[area.SBB_LOC], area.WORLD_MAP_LENGTH/2); 

	moving = 0;
	// Now we can use the generic WORLD_TILES and WORLD_MAP to draw everything

}

void drawMap() {

	DMANow(3, area.SCREEN_MAP, &SCREENBLOCKBASE[area.SBB_LOC], area.WORLD_MAP_LENGTH/2);

}

// Use this when entering a new area to draw the intial map at the player's location
void initMap(int r, int c) {
	// make a 256x256 map with r and c being the top left tile
	// NOTE: r and c are 'tile' positions, not 'pixel' positions (1 tile = 8 pixels)
	for (int i = 0; i < 32; i++) {
		DMANow(3, &area.WORLD_MAP[OFFSET(i + r, 0 + c, area.WORLD_MAP_TILE_WIDTH)], &area.SCREEN_MAP[OFFSET(i, 0, 32)], 32);
	}
	area.TILE_ROW = r;
	area.TILE_COL = c;
	area.ROW_CURSOR = 0;
	area.COL_CURSOR = 0;
}

void worldToScreen(int screenR, int screenC, int worldR, int worldC) {
	area.SCREEN_MAP[ OFFSET(screenR, screenC, 32) ] = 
		area.WORLD_MAP[ OFFSET(worldR, worldC, area.WORLD_MAP_TILE_WIDTH) ];
}


// draw 2 cols worth of tiles to appear on the left
void moveMapLeft() {

	for (int x = 0; x <= 1; x++) {
		area.COL_CURSOR -= 1;
		area.TILE_COL -= 1;
		int temp_col_cursor = area.COL_CURSOR;
		if (area.COL_CURSOR < 0) temp_col_cursor = area.COL_CURSOR + 32;
		if (area.COL_CURSOR >= 32) temp_col_cursor = area.COL_CURSOR - 32;


		// for (int i = 0; i < 32; i++) {
		// 	worldToScreen(i, temp_col_cursor, area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL);
		// }

		for (int i = 0; i < area.ROW_CURSOR; i++) {
			worldToScreen(i, temp_col_cursor, 32-i, area.TILE_COL);
		}
		for (int i = area.ROW_CURSOR; i < 32; i++) {
			worldToScreen(i, temp_col_cursor, area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL);
		}
	}

	drawMap();
}

// draws 2 cols worth of tiles to appear on the right
void moveMapRight() {

	for (int x = 1; x >=0 ; x--) {

		area.COL_CURSOR += 1;
		area.TILE_COL += 1;
		int temp_col_cursor = area.COL_CURSOR;
		temp_col_cursor = area.COL_CURSOR + SCREEN_TILE_WIDTH - 1;

		if (temp_col_cursor >= 32) temp_col_cursor -= 32;

		for (int i = 0; i < area.ROW_CURSOR; i++) {
			worldToScreen(i, temp_col_cursor, 32+i, area.TILE_COL + SCREEN_TILE_WIDTH - 1);
		}
		for (int i = area.ROW_CURSOR; i < 32; i++) {
			worldToScreen(i, temp_col_cursor, area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL + SCREEN_TILE_WIDTH - 1);
		}
		
	}

	drawMap();	
}

void moveMapUp() {

	for (int x = 0; x <= 1; x++) {
		
		area.TILE_ROW -= 1;
		area.ROW_CURSOR -= 1;
		int temp_row_cursor = area.ROW_CURSOR;

		if (area.ROW_CURSOR < 0) temp_row_cursor = 32 + area.ROW_CURSOR;

		for (int i = 0; i < area.COL_CURSOR + 1; i++) {
			worldToScreen(temp_row_cursor, i, area.TILE_ROW, 32 + i);
		}

		for (int i = area.COL_CURSOR; i < 32; i++) {
			worldToScreen(temp_row_cursor, i, area.TILE_ROW, area.TILE_COL - area.COL_CURSOR + i);
		}
	}

	drawMap();
}

void moveMapDown() {


	for (int x = 1; x >= 0; x--) {

		area.TILE_ROW += 1;
		area.ROW_CURSOR += 1;
		int temp_row_cursor = area.ROW_CURSOR;

		if (area.ROW_CURSOR < 0) temp_row_cursor = 0;
		if (area.ROW_CURSOR > 32) temp_row_cursor = area.ROW_CURSOR - 32;
		
		for (int i = 0; i < area.COL_CURSOR + 1; i++) {
			worldToScreen(temp_row_cursor - 1, i, 32 + area.TILE_ROW - 1, 32 + i);
		}		
		for (int i = area.COL_CURSOR; i < 32; i++) {
			worldToScreen(temp_row_cursor - 1, i, 32 + area.TILE_ROW - 1, area.TILE_COL - area.COL_CURSOR + i);			}
		}
	

	drawMap();
}