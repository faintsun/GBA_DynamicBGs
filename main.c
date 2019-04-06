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

AREAMAP* currMap;
AREAMAP DEWFORD_OVERWORLD;
AREAMAP LITTLEROOT_OVERWORLD;





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

	DEWFORD_OVERWORLD.tiles = dewfordTiles;
	DEWFORD_OVERWORLD.tlen = dewfordTilesLen;
	DEWFORD_OVERWORLD.map = dewfordMap;
	DEWFORD_OVERWORLD.mlen = dewfordMapLen;
	DEWFORD_OVERWORLD.tilew = 50;
	DEWFORD_OVERWORLD.tileh = 48;
	DEWFORD_OVERWORLD.cbb = 0;
	DEWFORD_OVERWORLD.sbb = 31;

	LITTLEROOT_OVERWORLD.tiles = littlerootTiles;
	LITTLEROOT_OVERWORLD.tlen = littlerootTilesLen;
	LITTLEROOT_OVERWORLD.map = littlerootMap;
	LITTLEROOT_OVERWORLD.mlen = littlerootMapLen;
	LITTLEROOT_OVERWORLD.tilew = 68;
	LITTLEROOT_OVERWORLD.tileh = 50;
	LITTLEROOT_OVERWORLD.cbb = 0;
	LITTLEROOT_OVERWORLD.sbb = 31;

	currMap = &DEWFORD_OVERWORLD;
	loadPalette(dewfordPal);
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

void draw(CURRENTMAP* a) {
	hideSprites();

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

	DMANow(3, shadowOAM, OAM, 128 * 4);

}


void buttonHandler(CURRENTMAP* a) {
	oldButtons = buttons;
	buttons = BUTTONS;

	if (BUTTON_PRESSED(BUTTON_A)) {
		AREAMAP* currMap = &LITTLEROOT_OVERWORLD;
		loadPalette(littlerootPal);
		loadMap(currMap, 0, 0);
		hOff = 0; vOff = 0;
	}

	if (BUTTON_PRESSED(BUTTON_B)) {
		AREAMAP* currMap = &DEWFORD_OVERWORLD;
		loadPalette(dewfordPal);
		loadMap(currMap, 0, 0);
		hOff = 0; vOff = 0;
	}

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