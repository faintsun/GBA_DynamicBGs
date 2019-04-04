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

	area.worldTileLen = tlen;
	area.worldMapLen = mlen;
	area.worldTileW = tilew;
	area.worldTileH = tileh;
	area.CBB_LOC = cbb;
	area.SBB_LOC = sbb;

	DMANow(3, tiles, area.WORLD_TILES, tlen/2); 
	DMANow(3, map, area.WORLD_MAP, mlen/2);

	DMANow(3, area.WORLD_TILES, &CHARBLOCKBASE[area.CBB_LOC], area.worldTileLen/2);
	
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
		DMANow(3, &area.WORLD_MAP[OFFSET(i + r, 0 + c, area.worldTileW)], &area.SCREEN_MAP[OFFSET(i, 0, 32)], 32);
	}
	area.tileR = r;
	area.tileC = c;
	area.offsetR = 0;
	area.offsetC = 0;

	drawMap();
}

void worldToScreen(int screenR, int screenC, int worldR, int worldC) {
	area.SCREEN_MAP[ OFFSET(screenR, screenC, 32) ] = 
		area.WORLD_MAP[ OFFSET(worldR, worldC, area.worldTileW) ];
}

void cursorReset() {
	if (cursorC < 0) cursorC += 32;
	if (cursorC > 32) cursorC -= 32;
	if (cursorR < 0) cursorR += 32;
	if (cursorR > 32) cursorR -= 32;
}

void moveMapLeft() {
	for (int x = 0; x <= 1; x++) {
		area.offsetC -= 1;
		area.tileC -= 1;
		cursorC = area.offsetC;

		cursorReset();

		for (int i = 0; i < 32; i++ ) {
			if (i < area.offsetR - SCREEN_TILE_HEIGHT/2) worldToScreen(i, cursorC, 32 + area.tileR - area.offsetR + i, area.tileC);
			else worldToScreen(i, cursorC, area.tileR - area.offsetR + i, area.tileC);
		}
	}
	drawMap();
}

void moveMapRight() {
	for (int x = 1; x >=0 ; x--) {

		area.offsetC += 1;
		area.tileC += 1;
		cursorC = area.offsetC;

		cursorReset();

		int tempCursor = cursorC + SCREEN_TILE_WIDTH;
		while (tempCursor > 32) tempCursor -= 32;
	
		for (int i = 0; i < 32; i++) {
			if (i < area.offsetR - SCREEN_TILE_HEIGHT/2) worldToScreen(i, tempCursor - 1,  32 + area.tileR - area.offsetR + i, area.tileC + SCREEN_TILE_WIDTH - 1);
			else worldToScreen(i, tempCursor - 1, area.tileR - area.offsetR + i, area.tileC + SCREEN_TILE_WIDTH - 1);
		}
	}

	drawMap();	
}

void moveMapUp() {
	for (int x = 0; x <= 1; x++) {
		
		area.tileR -= 1;
		area.offsetR -= 1;
		cursorR = area.offsetR;

		cursorReset();

		for (int i = 0; i < 32; i++) {
			if (i < cursorC) worldToScreen(cursorR, i, area.tileR, 32 + i);
			else worldToScreen(cursorR, i, area.tileR, area.tileC - area.offsetC + i);
		}
		// for (int i = 0; i < area.offsetC + 1; i++) {
		// 	worldToScreen(cursorR, i, area.tileR, 32 + i);
		// }

		// for (int i = area.offsetC; i < 32; i++) {
		// 	worldToScreen(cursorR, i, area.tileR, area.tileC - area.offsetC + i);
		// }
	}

	drawMap();
}

void moveMapDown() {
	for (int x = 1; x >= 0; x--) {

		area.tileR += 1;
		area.offsetR += 1;
		cursorR = area.offsetR + SCREEN_TILE_HEIGHT;

		cursorReset();

		for (int i = 0; i < 32; i++) {
			if (i < cursorC) worldToScreen(cursorR - 1, i, SCREEN_TILE_HEIGHT + area.tileR-1, 32 + i);
			else worldToScreen(cursorR - 1, i, SCREEN_TILE_HEIGHT + area.tileR-1, (area.tileC - area.offsetC) + i );
		}

	}

	drawMap();
}