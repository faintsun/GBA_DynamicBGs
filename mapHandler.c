#include "mapHandler.h"
#include "myLib.h"

unsigned short SCREEN_MAP[1024];		// the map we'll draw to the screen
unsigned short WORLD_TILES[8000];		// all the tiles in our current area
unsigned short WORLD_MAP[2500];			// the entire map of our current area
unsigned short WORLD_TILE_LENGTH;		// length of area tiles
unsigned short WORLD_MAP_LENGTH;		// length of area map
unsigned short WORLD_MAP_TILE_WIDTH;	// how many tiles wide our area map is
unsigned short WORLD_MAP_TILE_HEIGHT;	// how many tiles tall our area map is
unsigned short TILE_COL;				// our current leftmost col position on the area map
unsigned short TILE_ROW;				// our current topmost row position on the area map

// Use this when entering a new area to load the area's tiles & map
void loadMap(const unsigned short* tiles, const unsigned short tlen, // tiles of new area
				const unsigned short* map, const unsigned short mlen,   // map of new area
				unsigned short tilew, unsigned short tileh) {			// witdh and height of area in 8x8 tiles

	WORLD_TILE_LENGTH = tlen;
	WORLD_MAP_LENGTH = mlen;
	WORLD_MAP_TILE_WIDTH = tilew;
	WORLD_MAP_TILE_HEIGHT = tileh;
	DMANow(3, tiles, WORLD_TILES, tlen/2); 
	DMANow(3, map, WORLD_MAP, mlen/2);
	// Now we can use the generic WORLD_TILES and WORLD_MAP to draw everything

}

// Use this when entering a new area to draw the intial map at the player's location
void initMap(int r, int c) {
	// make a 256x256 map with r and c being the top left tile
	// NOTE: r and c are 'tile' positions, not 'pixel' positions (1 tile = 8 pixels)
	for (int i = 0; i < SCREEN_TILE_HEIGHT; i++) {
		DMANow(3, &WORLD_MAP[OFFSET(i + r, 0 + c, WORLD_MAP_TILE_WIDTH)], &SCREEN_MAP[OFFSET(i, 0, 32)], 32);
	}
	TILE_ROW = r;
	TILE_COL = c;
}

// draw 2 cols worth of tiles to the left 
void moveMapLeft(int tileCol) {

	
	for (int i = 0; i < SCREEN_TILE_HEIGHT; i++) {
		SCREEN_MAP[OFFSET(i, tileCol - 2, 32)] = WORLD_MAP[OFFSET(i, tileCol - 2, WORLD_MAP_TILE_WIDTH)];
		SCREEN_MAP[OFFSET(i, tileCol - 1, 32)] = WORLD_MAP[OFFSET(i, tileCol - 1, WORLD_MAP_TILE_WIDTH)];
	}
}

void moveMapRight() {
	//if (delayRightMove == 2) {
		//if (TILE_COL >=2) {
			for (int i = 0; i < SCREEN_TILE_HEIGHT; i++) {
				SCREEN_MAP[OFFSET(i, TILE_COL - 2, 32)] = WORLD_MAP[OFFSET(i, SCREEN_TILE_WIDTH + TILE_COL, WORLD_MAP_TILE_WIDTH)];
				SCREEN_MAP[OFFSET(i, TILE_COL - 1, 32)] = WORLD_MAP[OFFSET(i, SCREEN_TILE_WIDTH + TILE_COL + 1, WORLD_MAP_TILE_WIDTH)];
			}
			TILE_COL += 2;
		//}
		//delayRightMove = 0;
		DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[26], WORLD_MAP_LENGTH/2);
	//}
}


