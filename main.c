// code
#include "main.h"
#include "Library/myLib.h"

#include "Library/mapHandler.h"

// backgrounds

#include "Maps/littleroot.h"


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

		buttonHandler();
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

	loadPalette(littlerootPal);
	loadMap(littlerootTiles, littlerootTilesLen, littlerootMap, littlerootMapLen, 68, 50);

	DMANow(3, WORLD_TILES, &CHARBLOCKBASE[0], WORLD_TILE_LENGTH/2);

	initMap(0, 0);

	dirTimer = 16;

	DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[31], WORLD_MAP_LENGTH/2); // fix


}



void buttonHandler() {
	oldButtons = buttons;
	buttons = BUTTONS;

	if (!moving) {
		if(BUTTON_HELD(BUTTON_RIGHT)) {
			if (TILE_COL < WORLD_MAP_TILE_WIDTH - SCREEN_TILE_WIDTH) {
				nextMove = moveMapRight;
				moving = 1;
				//nextMove();
			}
		}

		if(BUTTON_HELD(BUTTON_LEFT)) {
			if (TILE_COL > 0) {
				nextMove = moveMapLeft;
				moving = 1;
				nextMove();
			}
		}
		if(BUTTON_HELD(BUTTON_DOWN)) {
			if (TILE_ROW < WORLD_MAP_TILE_HEIGHT - SCREEN_TILE_HEIGHT) {
				nextMove = moveMapDown;
				moving = 1;
				//nextMove();
			}
		}
		if(BUTTON_HELD(BUTTON_UP)) {
			if (TILE_ROW > 0) {
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
			if (nextMove == moveMapRight || nextMove == moveMapDown) {
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