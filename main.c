#include <stdio.h>
#include <stdlib.h>

// code
#include "main.h"
#include "Library/myLib.h"
#include "Library/mapHandler.h"

// backgrounds

#include "Maps/littleroot.h"
#include "Maps/dewford.h"
#include "Maps/spriteSheet.h"


// variables
unsigned int buttons;
unsigned int oldButtons;

int hOff = 0;
int vOff = 0;

OBJ_ATTR shadowOAM[128];
enum { ROWLOC = 0, COLLOC = 1, ROWNUMS = 2, ROWOFF = 4, COLNUMS = 6, COLOFF = 8, ROWCURS = 10, COLCURS = 12 };

int dir = 0;
int moving = 0;
int dirTimer;



extern const unsigned short* palette;



// prototypes
void (*nextMove)();

void init();
void draw();
void updateScreenLocations();
void buttonHandler();
void cameraHandler();
void hideSprites();

int main() {
	init();

	while(1) {

		buttonHandler(&area);
		cameraHandler();


		updateScreenLocations();
		draw(&area);
		waitForVblank();


	}

}



void init() {

	REG_DISPCTL = MODE0 | BG2_ENABLE | SPRITE_ENABLE;
	REG_BG2CNT = CBB(0) | SBB(31) | BG_SIZE0 | COLOR256;

	// loadPalette(littlerootPal);
	// loadMap(littlerootTiles, littlerootTilesLen, littlerootMap, littlerootMapLen, 68, 50, 0, 31);

	loadPalette(dewfordPal);
	loadMap(dewfordTiles, dewfordTilesLen, dewfordMap, dewfordMapLen, 50, 48, 0, 31);
	initMap(10, 0);

	DMANow(3, spriteSheetPal, SPRITE_PALETTE, 256);
	DMANow(3, spriteSheetTiles, &CHARBLOCKBASE[4], spriteSheetTilesLen/2);


	dirTimer = 16;


}



void hideSprites() {
    for (int i = 0; i < 128; i++) {
    	shadowOAM[i].attr0 = ATTR0_HIDE;
    }

}

void draw(AREAMAP* area) {
	hideSprites();


	shadowOAM[ROWLOC].attr0 = ATTR0_WIDE | 16;
	shadowOAM[ROWLOC].attr1 = 152 | ATTR1_SIZE8;
	shadowOAM[ROWLOC].attr2 = SPRITEOFFSET16(2,0);

	shadowOAM[COLLOC].attr0 = ATTR0_WIDE | 24;
	shadowOAM[COLLOC].attr1 = 152 | ATTR1_SIZE8;
	shadowOAM[COLLOC].attr2 = SPRITEOFFSET16(1,0);

	// draw row values
	for (int i = 0; i < 2; i++) {
		shadowOAM[ROWNUMS + i].attr0 = 16;
		shadowOAM[ROWNUMS + i].attr1 = ATTR1_SIZE8 | (176 - (i*8));
		shadowOAM[ROWNUMS + i].attr2 = SPRITEOFFSET16(0, getDigit(area->tileR, i));	
	}

	int rNeg = 0;
	if (area->offsetR < 0) rNeg = 4;

	for (int i = 0; i < 2; i++) {
		shadowOAM[ROWOFF + i].attr0 = 16;
		shadowOAM[ROWOFF + i].attr1 = ATTR1_SIZE8 | (200 - (i*8));
		shadowOAM[ROWOFF + i].attr2 = SPRITEOFFSET16(rNeg, getDigit(abs(area->offsetR), i));	
	}

	rNeg = 0;
	if (area->cursorR < 0) rNeg = 4;

	for (int i = 0; i < 2; i++) {
		shadowOAM[ROWCURS + i].attr0 = 16;
		shadowOAM[ROWCURS + i].attr1 = ATTR1_SIZE8 | (224 - (i*8));
		shadowOAM[ROWCURS + i].attr2 = SPRITEOFFSET16(rNeg, getDigit(abs(area->cursorR), i));	
	}

	// draw col values
	for (int i = 0; i < 2; i++) {
		shadowOAM[COLNUMS + i].attr0 = 24;
		shadowOAM[COLNUMS + i].attr1 = ATTR1_SIZE8 | (176 - (i*8));
		shadowOAM[COLNUMS + i].attr2 = SPRITEOFFSET16(0, getDigit(area->tileC, i));	
	}

	int cNeg = 0;
	if (area->offsetC < 0) cNeg = 4;

	for (int i = 0; i < 2; i++) {
		shadowOAM[COLOFF + i].attr0 = 24;
		shadowOAM[COLOFF + i].attr1 = ATTR1_SIZE8 | (200 - (i*8));
		shadowOAM[COLOFF + i].attr2 = SPRITEOFFSET16(cNeg, getDigit(abs(area->offsetC), i));	
	}

	cNeg = 0;
	if (area->cursorC < 0) cNeg = 4;
	for (int i = 0; i < 2; i++) {
		shadowOAM[COLCURS + i].attr0 = 24;
		shadowOAM[COLCURS + i].attr1 = ATTR1_SIZE8 | (224 - (i*8));
		shadowOAM[COLCURS + i].attr2 = SPRITEOFFSET16(cNeg, getDigit(abs(area->cursorC), i));	
	}

	DMANow(3, shadowOAM, OAM, 128 * 4);

}


void buttonHandler(AREAMAP* area) {
	oldButtons = buttons;
	buttons = BUTTONS;

	if (!moving) {
		int inputCheck = 0;
		if(BUTTON_HELD(BUTTON_RIGHT)) {
			if (area->tileC < area->worldTileW - SCREEN_TILE_WIDTH) {
				nextMove = moveMapRight;
				inputCheck = 1;

			}
		}

		else if(BUTTON_HELD(BUTTON_LEFT)) {
			if (area->tileC > 0) {
				nextMove = moveMapLeft;
				inputCheck = 1;
			}
		}
		else if(BUTTON_HELD(BUTTON_DOWN)) {
			if (area->tileR < area->worldTileH - SCREEN_TILE_HEIGHT - 2) {
				nextMove = moveMapDown;
				inputCheck = 1;
			}
		}
		else if(BUTTON_HELD(BUTTON_UP)) {
			if (area->tileR > 0) {
				nextMove = moveMapUp;
				inputCheck = 1;
			}

		}

		if (inputCheck) {
			moving = 1;
			nextMove();
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