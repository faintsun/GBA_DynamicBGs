#include "mapHandler.h"
#include "myLib.h"

#include <stdio.h>
#include <stdlib.h>


AREAMAP area;




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

void worldToScreen(int screenR, int screenC, int worldR, int worldC) {
	area.SCREEN_MAP[ OFFSET(screenR, screenC, 32) ] = 
		area.WORLD_MAP[ OFFSET(worldR, worldC, area.worldTileW) ];
}

void cursorReset() {
	if (area.cursorC < 0) { 
		if (area.mapRight >= 32) area.mapRight -= 32;
		area.cursorC += 32; area.mapLeft += 32;
	}

	if (area.cursorC > 32) {
		if (area.mapLeft >= 32) area.mapLeft -= 32;
		area.cursorC -= 32;
	}

	// start drawing from row 32
	if (area.cursorR < 0) { 
		if (area.mapDown >= 32) area.mapDown -= 32; 
		area.cursorR += 32; area.mapUp += 32; 
	}

	// start drawing from row 0
	if (area.cursorR > 32) { 
		if (area.mapUp >= 32) area.mapUp -= 32;
		area.cursorR -= 32; 
	}

	if (area.tileR - area.offsetR == 0) { area.mapDown = 0; area.mapUp = 0; }
	if (area.tileC - area.offsetC == 0) { area.mapLeft = 0; area.mapRight = 0; }


}


void moveMapLeft() {
	for (int x = 0; x <= 1; x++) {
		//area.offsetC -= 1;
		area.tileC--;
		area.cursorC--;

		cursorReset();

		for (int i = 0; i < 32; i++ ) {
			if (i < area.cursorR) worldToScreen(i, area.cursorC, area.tileR - (area.tileR - area.offsetR) + i + area.mapDown, area.tileC);
			else worldToScreen(i, area.cursorC, area.tileR - (area.tileR - area.offsetR) + i - area.mapUp, area.tileC);
		}
	}
	drawMap();
}

void moveMapRight() {
	for (int x = 1; x >=0 ; x--) {

		area.tileC += 1;
		area.cursorC += 1;

		if ( (area.cursorC + SCREEN_TILE_WIDTH) % 32 == 0 ) area.mapRight += 32; 

		int tempCursor = area.cursorC + SCREEN_TILE_WIDTH;
		if (tempCursor > 32) tempCursor -= 32;

		cursorReset();

		for (int i = 0; i < 32; i++) {
			if (i < area.cursorR) worldToScreen(i, tempCursor-1, area.tileR - (area.tileR - area.offsetR) + i + area.mapDown, area.tileC + SCREEN_TILE_WIDTH - 1);
		 	else worldToScreen(i, tempCursor-1, area.tileR - (area.tileR - area.offsetR) + i - area.mapUp, area.tileC + SCREEN_TILE_WIDTH - 1);
			
		}
	}

	drawMap();	
}

void moveMapUp() {
	for (int x = 0; x <= 1; x++) {
		
		area.tileR--;
		area.cursorR--;

		cursorReset();

		for (int i = 0; i < 32; i++) {
			if (i < area.cursorC) worldToScreen(area.cursorR, i, area.tileR, area.tileC - (area.tileC - area.offsetC) + i + area.mapRight );
			else worldToScreen(area.cursorR, i, area.tileR, area.tileC - (area.tileC - area.offsetC) + i - area.mapLeft);
		}

	}

	drawMap();
}

void moveMapDown() {
	for (int x = 1; x >= 0; x--) {

		area.tileR++;
		area.cursorR++;

		if ( (area.cursorR + SCREEN_TILE_HEIGHT) % 32 == 0 ) area.mapDown += 32; 
	

		int tempCursor = area.cursorR + SCREEN_TILE_HEIGHT;
		if (tempCursor > 32) tempCursor -= 32;

		cursorReset();

		for (int i = 0; i < 32; i++) {
			if (i < area.cursorC) worldToScreen(tempCursor-1, i, SCREEN_TILE_HEIGHT + area.tileR-1, area.tileC - (area.tileC - area.offsetC) + i + area.mapRight);
			else worldToScreen(tempCursor-1, i, SCREEN_TILE_HEIGHT + area.tileR-1, area.tileC - (area.tileC - area.offsetC) + i - area.mapLeft );

		}

	}

	drawMap();
}