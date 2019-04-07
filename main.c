#include <stdio.h>
#include <stdlib.h>

// code
#include "Library/myLib.h"
#include "Library/mapHandler.h"

// maps
#include "Maps/mapList.h"
#include "Maps/spriteSheet.h"

// header
#include "main.h"


int main() {
	init();

	while(1) {

		buttonHandler(CURRENT_AREA_P);
		cameraHandler();

		updateScreenLocations();
		draw();
		waitForVblank();


	}

}



void init() {

	REG_DISPCTL = MODE0 | BG2_ENABLE | SPRITE_ENABLE;
	REG_BG2CNT = CBB(0) | SBB(AREA_BG2_SBB) | BG_SIZE0 | COLOR256;

	initialize_mapHandler();
	initialize_mapList();

	currMap = &(*MAP_ARRAY)[LITTLEROOT_TOWN];
	loadPalette(currMap);
	loadMap(currMap, 8, 8);

	DMANow(3, spriteSheetPal, SPRITE_PALETTE, 256);
	DMANow(3, spriteSheetTiles, &CHARBLOCKBASE[4], spriteSheetTilesLen/2);


	dirTimer = 16;
}

void hideSprites() {
    for (int i = 0; i < 128; i++) {
    	shadowOAM[i].attr0 = ATTR0_HIDE;
    }
}

void draw() {
	hideSprites();
	drawHelperNumbers(CURRENT_AREA_P);
	DMANow(3, shadowOAM, OAM, 128 * 4);

}

void buttonHandler(CURRENTMAP* a) {
	oldButtons = buttons;
	buttons = BUTTONS;

	if (!moving) {
		int inputCheck = 0;
		if(BUTTON_HELD(BUTTON_RIGHT)) {
			if (a->tileC < a->worldTileW - SCREEN_TILE_WIDTH) {
				nextMove = moveMapRight;
				inputCheck = 1;
			}
		}

		else if(BUTTON_HELD(BUTTON_LEFT)) {
			if (a->tileC > 0) {
				nextMove = moveMapLeft;
				inputCheck = 1;
			}
		}
		else if(BUTTON_HELD(BUTTON_DOWN)) {
			if (a->tileR < a->worldTileH - SCREEN_TILE_HEIGHT - 2) {
				nextMove = moveMapDown;
				inputCheck = 1;
			}
		}
		else if(BUTTON_HELD(BUTTON_UP)) {
			if (a->tileR > 0) {
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

	REG_BG2HOFS = hOff;
	REG_BG2VOFS = vOff;
}

void drawHelperNumbers(CURRENTMAP* a) {
	// draws col/row variables to screen
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
		shadowOAM[ROWNUMS + i].attr2 = SPRITEOFFSET16(0, getDigit(a->tileR, i));	
	}

	int rNeg = 0;
	if (a->offsetR < 0) rNeg = 4;

	for (int i = 0; i < 2; i++) {
		shadowOAM[ROWOFF + i].attr0 = 16;
		shadowOAM[ROWOFF + i].attr1 = ATTR1_SIZE8 | (200 - (i*8));
		shadowOAM[ROWOFF + i].attr2 = SPRITEOFFSET16(rNeg, getDigit(abs(a->cursorR), i));	
	}

	rNeg = 0;
	if (a->cursorR < 0) rNeg = 4;

	for (int i = 0; i < 2; i++) {
		shadowOAM[ROWCURS + i].attr0 = 16;
		shadowOAM[ROWCURS + i].attr1 = ATTR1_SIZE8 | (224 - (i*8));
		shadowOAM[ROWCURS + i].attr2 = SPRITEOFFSET16(rNeg, getDigit(abs(a->mapUp), i));	
	}

	// draw col values
	for (int i = 0; i < 2; i++) {
		shadowOAM[COLNUMS + i].attr0 = 24;
		shadowOAM[COLNUMS + i].attr1 = ATTR1_SIZE8 | (176 - (i*8));
		shadowOAM[COLNUMS + i].attr2 = SPRITEOFFSET16(0, getDigit(a->tileC, i));	
	}

	int cNeg = 0;
	if (a->offsetC < 0) cNeg = 4;

	for (int i = 0; i < 2; i++) {
		shadowOAM[COLOFF + i].attr0 = 24;
		shadowOAM[COLOFF + i].attr1 = ATTR1_SIZE8 | (200 - (i*8));
		shadowOAM[COLOFF + i].attr2 = SPRITEOFFSET16(cNeg, getDigit(abs(a->cursorC), i));	
	}

	cNeg = 0;
	if (a->cursorC < 0) cNeg = 4;
	for (int i = 0; i < 2; i++) {
		shadowOAM[COLCURS + i].attr0 = 24;
		shadowOAM[COLCURS + i].attr1 = ATTR1_SIZE8 | (224 - (i*8));
		shadowOAM[COLCURS + i].attr2 = SPRITEOFFSET16(cNeg, getDigit(abs(a->mapDown), i));	
	}
}