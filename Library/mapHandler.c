#include "mapHandler.h"
#include "myLib.h"

#include <stdio.h>
#include <stdlib.h>


AREAMAP area;
int cursorC;
int cursorR;

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
	
	moving = 0;
	// Now we can use the generic WORLD_TILES and WORLD_MAP to draw everything

}

void drawMap() {

	DMANow(3, area.SCREEN_MAP, &SCREENBLOCKBASE[area.SBB_LOC], 1024);

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

	drawMap();
}

void worldToScreen(int screenR, int screenC, int worldR, int worldC) {
	area.SCREEN_MAP[ OFFSET(screenR, screenC, 32) ] = 
		area.WORLD_MAP[ OFFSET(worldR, worldC, area.WORLD_MAP_TILE_WIDTH) ];
}

void cursorReset() {
	if (cursorC < 0) cursorC += 32;
	if (cursorC > 32) cursorC -= 32;
	if (cursorR < 0) cursorR += 32;
	if (cursorR > 32) cursorR -= 32;
}

void moveMapLeft() {
	for (int x = 0; x <= 1; x++) {
		area.COL_CURSOR -= 1;
		area.TILE_COL -= 1;
		cursorC = area.COL_CURSOR;

		cursorReset();

		for (int i = 0; i < 32; i++ ) {
			if (i < cursorR) worldToScreen(i, cursorC, 32 + area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL);
			else worldToScreen(i, cursorC, area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL);
		}
	}


	drawMap();
}

void moveMapRight() {
	for (int x = 1; x >=0 ; x--) {

		area.COL_CURSOR += 1;
		area.TILE_COL += 1;
		cursorC = area.COL_CURSOR;

		cursorReset();

		int tempCursor = cursorC + SCREEN_TILE_WIDTH;
		if (tempCursor > 32) tempCursor -= 32;
	
		for (int i = 0; i < 32; i++) {
			if (i < cursorR) worldToScreen(i, tempCursor - 1,  32 + area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL + SCREEN_TILE_WIDTH - 1);
			else worldToScreen(i, tempCursor - 1, area.TILE_ROW - area.ROW_CURSOR + i, area.TILE_COL + SCREEN_TILE_WIDTH - 1);
		}
	}

	drawMap();	
}

void moveMapUp() {
	for (int x = 0; x <= 1; x++) {
		
		area.TILE_ROW -= 1;
		area.ROW_CURSOR -= 1;
		cursorR = area.ROW_CURSOR;

		cursorReset();

		for (int i = 0; i < area.COL_CURSOR + 1; i++) {
			worldToScreen(cursorR, i, area.TILE_ROW, 32 + i);
		}

		for (int i = area.COL_CURSOR; i < 32; i++) {
			worldToScreen(cursorR, i, area.TILE_ROW, area.TILE_COL - area.COL_CURSOR + i);
		}
	}

	drawMap();
}

void moveMapDown() {
	for (int x = 1; x >= 0; x--) {

		area.TILE_ROW += 1;
		area.ROW_CURSOR += 1;
		cursorR = area.ROW_CURSOR + SCREEN_TILE_HEIGHT;

		cursorReset();

		for (int i = 0; i < area.COL_CURSOR + 2; i++) {
			worldToScreen(cursorR - 1, i, 
				SCREEN_TILE_HEIGHT + area.TILE_ROW-1, 32 + i);

		}		
		for (int i = area.COL_CURSOR; i < 32; i++) {
			worldToScreen(cursorR - 1, i, 
				SCREEN_TILE_HEIGHT + area.TILE_ROW-1, (area.TILE_COL - area.COL_CURSOR) + i );			
		}
	}

	drawMap();
}