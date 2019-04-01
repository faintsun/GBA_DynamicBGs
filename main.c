// code
#include "main.h"
#include "myLib.h"
#include "house.h"
#include "mapHandler.h"

// backgrounds
#include "bg1.h"
#include "bg2.h"
#include "littleroot.h"
#include "littleroot256.h"

// variables
unsigned int buttons;
unsigned int oldButtons;

int hOff = 0;
int vOff = 0;
int moving = 0;
int dir = 0;
int dirTimer = 16;
enum {LEFT, RIGHT, DOWN, UP};

int delayRightMove = 0;

extern const unsigned short* palette;



// prototypes
void initMode0();
void updateScreenLocations();
void buttonHandler();
void cameraHandler();

int main() {
	initMode0();

	while(1) {

		if (!moving) {
			buttonHandler();
		} else {
			cameraHandler();
		}


		if (delayRightMove == 2) {
		if (TILE_COL >=2) {
			for (int i = 0; i < SCREEN_TILE_HEIGHT; i++) {
				SCREEN_MAP[OFFSET(i, TILE_COL - 2, 32)] = littlerootMap[OFFSET(i, SCREEN_TILE_WIDTH + TILE_COL, WORLD_MAP_TILE_WIDTH)];
				SCREEN_MAP[OFFSET(i, TILE_COL - 1, 32)] = littlerootMap[OFFSET(i, SCREEN_TILE_WIDTH + TILE_COL + 1, WORLD_MAP_TILE_WIDTH)];
			}
		}
		delayRightMove = 0;
		DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[26], littleroot256MapLen/2);
	}

		updateScreenLocations();

		waitForVblank();
		waitForVblank();
		waitForVblank();

	}

}



void initMode0() {

	REG_DISPCTL = MODE0 | BG2_ENABLE;
	REG_BG2CNT = CBB(0) | SBB(26) | BG_SIZE0 | COLOR256;

	loadPalette(littlerootPal);
	loadMap(littlerootTiles, littlerootTilesLen, littlerootMap, littlerootMapLen, 48, 44);

	DMANow(3, WORLD_TILES, &CHARBLOCKBASE[0], WORLD_TILE_LENGTH/2);

	initMap(0, 0);

	DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[26], WORLD_MAP_LENGTH/2); // fix


}



void buttonHandler() {
	oldButtons = buttons;
	buttons = BUTTONS;

	if(BUTTON_HELD(BUTTON_RIGHT)) {
		
		if (TILE_COL < WORLD_MAP_TILE_WIDTH - SCREEN_TILE_WIDTH) {
			moving = 1;
			dir = RIGHT;
			TILE_COL += 2;
			delayRightMove = 1;
		}



	}
	if(BUTTON_HELD(BUTTON_LEFT)) {
		if (TILE_COL > 0) {
			moving = 1;
			dir = LEFT;
			

			moveMapLeft(TILE_COL);

			TILE_COL -= 2;

		DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[26], littleroot256MapLen/2);


		}
	}
	if(BUTTON_HELD(BUTTON_DOWN)) {
		moving = 1;
		dir = DOWN;
		TILE_ROW++;
		if (TILE_ROW > 6) {
			DMANow(3, &littlerootMap[OFFSET(SCREENHEIGHT/8 + TILE_ROW, 0, 32)], &SCREEN_MAP[OFFSET(TILE_ROW - 6, 0, 32)], 32);
			DMANow(3, SCREEN_MAP, &SCREENBLOCKBASE[26], littlerootMapLen/2);
		}
	}
	if(BUTTON_HELD(BUTTON_UP)) {
		if (TILE_ROW > 0) {
			moving = 1;
			dir = UP;
			TILE_ROW--;
		}
	}

}

void cameraHandler() {


	
	dirTimer--;
	if (dir == LEFT) {
		hOff--;
	} else if (dir == RIGHT) {
		hOff++;
	} else if (dir == DOWN) {
		vOff++;
	} else if (dir == UP) {
		vOff--;
	}
	if (dirTimer < 1) {
		dirTimer = 16;
		delayRightMove = 2;
		moving = 0;
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
