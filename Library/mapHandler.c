#include "myLib.h"
#include "mapHandler.h"


#include <stdio.h>
#include <stdlib.h>

// Variables
CURRENTMAP area;
CURRENTMAP* CURRENT_AREA_P;
const unsigned short* palette;

void initialize_mapHandler() {
	CURRENT_AREA_P = &area;
}

// Use this when entering a new area to load the area's tiles & map
void loadMap(AREAMAP* m, int r, int c) {			 		

	area.worldTileLen = m->tlen;
	area.worldMapLen = m->mlen;
	area.worldTileW = m->tilew;
	area.worldTileH = m->tileh;

	DMANow(3, m->tiles, area.WORLD_TILES, area.worldTileLen/2); 
	DMANow(3, m->map_BG2, area.WORLD_MAP_BG2, area.worldMapLen/2);

	DMANow(3, area.WORLD_TILES, &CHARBLOCKBASE[AREA_TILE_CBB], area.worldTileLen/2);
	for (int i = 0; i < 32; i++) {
		DMANow(3, &area.WORLD_MAP_BG2[OFFSET(i + r, c, area.worldTileW)], &area.SCREEN_MAP_BG2[OFFSET(i, 0, 32)], 32);
	}

	area.tileR = r;
	area.tileC = c;
	area.offsetR = r;
	area.offsetC = c;
	area.cursorR = 0;
	area.cursorC = 0;

	area.mapUp = 0;
	area.mapDown = 0;
	area.mapLeft = 0;
	area.mapRight = 0;

	drawMap();
}

void loadPalette(AREAMAP* m) {
	DMANow(3, (unsigned short*)m->pal, PALETTE, 256);
}

// Copies the screen map into the screenblock base
void drawMap() {
	DMANow(3, area.SCREEN_MAP_BG2, &SCREENBLOCKBASE[AREA_BG2_SBB], 1024);
}


// helper function to update the screen's map so the move functions are less cluttered
void worldToScreen(int screenR, int screenC, int worldR, int worldC) {
	area.SCREEN_MAP_BG2[ OFFSET(screenR, screenC, 32) ] = 
		area.WORLD_MAP_BG2[ OFFSET(worldR, worldC, area.worldTileW) ];
}

// keeps the cursor within 0 and 32
// also keep tracks of map offsets
void cursorReset() {
	// wrap from col -1 to col 31
	if (area.cursorC < 0) { 
		if (area.mapRight >= 32) area.mapRight -= 32;
		area.cursorC += 32; area.mapLeft += 32;
	}

	// wrap from col 33 to col 1
	if (area.cursorC > 32) {
		if (area.mapLeft >= 32) area.mapLeft -= 32;
		area.cursorC -= 32;
	}

	// wrap from row -1 to row 31
	if (area.cursorR < 0) { 
		area.cursorR += 32; area.mapUp += 32; 
	}

	// wrap from row 33 to row 1
	if (area.cursorR > 32) { 
		if (area.mapUp >= 32) area.mapUp -= 32;
		area.cursorR -= 32; 
	}

	// if (area.tileR - area.offsetR == 0) { area.mapDown = 0; area.mapUp = 0; }
	// if (area.tileC - area.offsetC == 0) { area.mapLeft = 0; area.mapRight = 0; }

}


void moveMapLeft() {
	for (int x = 0; x <= 1; x++) {
		area.tileC--; area.cursorC--;

		cursorReset();

		for (int i = 0; i < 32; i++ ) {
			if (i < area.cursorR) worldToScreen(i, area.cursorC, area.tileR - (area.tileR - area.offsetR) + i + area.mapDown, area.tileC);
			//if (i < area.cursorR) worldToScreen(i, area.cursorC, area.tileR - (area.tileR - area.offsetR) + i + area.mapDown, area.tileC);
			else worldToScreen(i, area.cursorC, area.tileR - (area.tileR - area.offsetR) + i - area.mapUp, area.tileC);
		}
	}
	drawMap();
}

void moveMapRight() {
	for (int x = 1; x >=0 ; x--) {
		area.tileC++; area.cursorC++;

		cursorReset();

		int tempCursor = area.cursorC + SCREEN_TILE_WIDTH;
		if (tempCursor > 32) tempCursor -= 32;
		if ( (area.cursorC + SCREEN_TILE_WIDTH) % 32 == 0 ) area.mapRight += 32; 

		for (int i = 0; i < 32; i++) {
			if (i < area.cursorR) worldToScreen(i, tempCursor-1, area.tileR - (area.tileR - area.offsetR) + i + area.mapDown, area.tileC + SCREEN_TILE_WIDTH - 1);
		 	else worldToScreen(i, tempCursor-1, area.tileR - (area.tileR - area.offsetR) + i - area.mapUp, area.tileC + SCREEN_TILE_WIDTH - 1);
		}
	}
	drawMap();	
}

void moveMapUp() {
	for (int x = 0; x <= 1; x++) {
		area.tileR--; area.cursorR--;

		cursorReset();
		if ( (area.cursorR + SCREEN_TILE_HEIGHT) % 32 == 0 ) area.mapDown -= 32; 

		for (int i = 0; i < 32; i++) {
			if (i < area.cursorC) worldToScreen(area.cursorR, i, area.tileR, area.tileC - (area.tileC - area.offsetC) + i + area.mapRight );
			else worldToScreen(area.cursorR, i, area.tileR, area.tileC - (area.tileC - area.offsetC) + i - area.mapLeft);
		}
	}
	drawMap();
}

void moveMapDown() {
	for (int x = 1; x >= 0; x--) {
		area.tileR++; area.cursorR++;

		cursorReset();

		int tempCursor = area.cursorR + SCREEN_TILE_HEIGHT;
		if (tempCursor > 32) tempCursor -= 32;
		if ( (area.cursorR + SCREEN_TILE_HEIGHT) % 32 == 0 ) area.mapDown += 32; 

		for (int i = 0; i < 32; i++) {
			if (i < area.cursorC) worldToScreen(tempCursor-1, i, SCREEN_TILE_HEIGHT + area.tileR-1, area.tileC - (area.tileC - area.offsetC) + i + area.mapRight);
			else worldToScreen(tempCursor-1, i, SCREEN_TILE_HEIGHT + area.tileR-1, area.tileC - (area.tileC - area.offsetC) + i - area.mapLeft );
		}
	}
	drawMap();
}