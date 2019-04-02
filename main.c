// code
#include "main.h"
#include "Library/myLib.h"
#include "Library/mapHandler.h"

// backgrounds

#include "Maps/littleroot.h"
#include "Maps/dewford.h"


// variables
unsigned int buttons;
unsigned int oldButtons;

int hOff = 0;
int vOff = 0;


int dir = 0;
int moving = 0;
int dirTimer;



extern const unsigned short* palette;



// prototypes
void (*nextMove)();

void init();
void updateScreenLocations();
void buttonHandler();
void cameraHandler();

int main() {
	init();

	while(1) {

		buttonHandler(&area);
		cameraHandler();

		updateScreenLocations();

		waitForVblank();
		waitForVblank();
		waitForVblank();

	}

}



void init() {

	REG_DISPCTL = MODE0 | BG2_ENABLE;
	REG_BG2CNT = CBB(0) | SBB(31) | BG_SIZE0 | COLOR256;

	// loadPalette(littlerootPal);
	// loadMap(littlerootTiles, littlerootTilesLen, littlerootMap, littlerootMapLen, 68, 50);

	loadPalette(dewfordPal);
	loadMap(dewfordTiles, dewfordTilesLen, dewfordMap, dewfordMapLen, 50, 48, 0, 31);
	initMap(0, 0);

	dirTimer = 16;

	drawMap();


}



void buttonHandler(AREAMAP* area) {
	oldButtons = buttons;
	buttons = BUTTONS;

	if (!moving) {
		if(BUTTON_HELD(BUTTON_RIGHT)) {
			if (area->TILE_COL < area->WORLD_MAP_TILE_WIDTH - SCREEN_TILE_WIDTH) {
				nextMove = moveMapRight;
				moving = 1;
				nextMove();
			}
		}

		if(BUTTON_HELD(BUTTON_LEFT)) {
			if (area->TILE_COL > 0) {
				nextMove = moveMapLeft;
				moving = 1;
				nextMove();
			}
		}
		if(BUTTON_HELD(BUTTON_DOWN)) {
			if (area->TILE_ROW < area->WORLD_MAP_TILE_HEIGHT - SCREEN_TILE_HEIGHT - 2) {
				nextMove = moveMapDown;
				moving = 1;
				//nextMove();
			}
		}
		if(BUTTON_HELD(BUTTON_UP)) {
			if (area->TILE_ROW > 0) {
				nextMove = moveMapUp;
				moving = 1;
				nextMove();
			}

		}
	}

}

void cameraHandler() {


	if (moving) {
		dirTimer--;
		if (nextMove == moveMapLeft) {
			hOff--;
		} else if (nextMove == moveMapRight) {
			hOff++;
		} else if (nextMove == moveMapDown) {
			vOff++;
		} else if (nextMove == moveMapUp) {
			vOff--;
		}

		if (dirTimer < 1) {

			dirTimer = 16;
			if ( nextMove == moveMapDown) {
				nextMove();
			}
			moving = 0;
		}
	}
}



void updateScreenLocations() {

	// if (hOff > 256) {
	// 	hOff = 0;
	// 	DMANow(3, bg2Tiles, &CHARBLOCKBASE[0], bg2TilesLen/2);
	// 	DMANow(3, bg2Map, &SCREENBLOCKBASE[28], bg2MapLen/2);
	// }
	REG_BG2HOFS = hOff;
	REG_BG2VOFS = vOff;
}