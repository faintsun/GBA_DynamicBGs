#include <stdio.h>
#include <stdlib.h>

// code
#include "Library/myLib.h"
#include "Library/mapHandler.h"

// maps
#include "Maps/mapList.h"

// sprites
#include "Sprites/spriteHandler.h"
#include "Sprites/spriteSheet.h"
#include "Sprites/testSprite.h"
#include "Sprites/s_May.h"

// header
#include "main.h"



int main() {
	init();

	player.worldCol = SCREENWIDTH / 2 - 8;
	player.worldRow = SCREENHEIGHT / 2 - 16;

	while(1) {

		
		buttonHandler(CURRENT_AREA_P);
		cameraHandler();

		updateScreenLocations();
		draw();
		waitForVblank();


	}

}



void init() {

	REG_DISPCTL = MODE0 | BG2_ENABLE | SPRITE_ENABLE | SPRITE_MODE_1D;
	REG_BG2CNT = CBB(0) | SBB(AREA_BG2_SBB) | BG_SIZE0 | COLOR256;

	initialize_mapHandler();
	initialize_mapList();

	currMap = &(*MAP_ARRAY)[LITTLEROOT_TOWN];
	loadPalette(currMap);
	loadMap(currMap, 8, 8);

	setSpritePal(s_MayPal);

	player.aniCounter = 32;

	dirTimer = 16;
}

void hideSprites() {
    for (int i = 0; i < 128; i++) {
    	shadowOAM[i].attr0 = ATTR0_HIDE;
    }
}

void draw() {
	hideSprites();

	drawPlayer();
	//drawHelperNumbers(CURRENT_AREA_P);
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
				player.aniDir = RIGHT;
			}
		}

		else if(BUTTON_HELD(BUTTON_LEFT)) {
			if (a->tileC > 0) {
				nextMove = moveMapLeft;
				inputCheck = 1;
				player.aniDir = LEFT;
			} 
		}
		else if(BUTTON_HELD(BUTTON_DOWN)) {
			if (a->tileR < a->worldTileH - SCREEN_TILE_HEIGHT - 2) {
				nextMove = moveMapDown;
				inputCheck = 1;
				player.aniDir = DOWN;
			}
		}
		else if(BUTTON_HELD(BUTTON_UP)) {
			if (a->tileR > 0) {
				nextMove = moveMapUp;
				inputCheck = 1;
				player.aniDir = UP;
			}
		}

		if (inputCheck) {
			moving = 1;
			startPlayerAniCounter();
			nextMove();
		} 
	}
}



void cameraHandler() {


	if (moving) {
		
		animatePlayer(&player);
		
		dirTimer--;
		if (nextMove == moveMapLeft) {
			player.worldCol--;
			hOff--;
		} else if (nextMove == moveMapRight) {
			player.worldCol++;
			hOff++;
		} else if (nextMove == moveMapDown) {
			player.worldRow++;
			vOff++;
		} else if (nextMove == moveMapUp) {
			player.worldRow--;
			vOff--;
		}

		if (dirTimer < 1) {

			dirTimer = 16;
			moving = 0;
			
		}
	} 
}


void updateScreenLocations() {


	player.screenRow = player.worldRow - vOff;
	player.screenCol = player.worldCol - hOff;

	REG_BG2HOFS = hOff;
	REG_BG2VOFS = vOff;
}

// void drawHelperNumbers(CURRENTMAP* a) {
// 	// draws col/row variables to screen
// 	shadowOAM[ROWLOC].attr0 = ATTR0_WIDE | 16;
// 	shadowOAM[ROWLOC].attr1 = 152 | ATTR1_SIZE8;
// 	shadowOAM[ROWLOC].attr2 = SPRITEOFFSET16(2,0);

// 	shadowOAM[COLLOC].attr0 = ATTR0_WIDE | 24;
// 	shadowOAM[COLLOC].attr1 = 152 | ATTR1_SIZE8;
// 	shadowOAM[COLLOC].attr2 = SPRITEOFFSET16(1,0);

// 	// draw row values
// 	for (int i = 0; i < 2; i++) {
// 		shadowOAM[ROWNUMS + i].attr0 = 16;
// 		shadowOAM[ROWNUMS + i].attr1 = ATTR1_SIZE8 | (176 - (i*8));
// 		shadowOAM[ROWNUMS + i].attr2 = SPRITEOFFSET16(0, getDigit(a->tileR, i));	
// 	}

// 	int rNeg = 0;
// 	if (a->offsetR < 0) rNeg = 4;

// 	for (int i = 0; i < 2; i++) {
// 		shadowOAM[ROWOFF + i].attr0 = 16;
// 		shadowOAM[ROWOFF + i].attr1 = ATTR1_SIZE8 | (200 - (i*8));
// 		shadowOAM[ROWOFF + i].attr2 = SPRITEOFFSET16(rNeg, getDigit(abs(a->cursorR), i));	
// 	}

// 	rNeg = 0;
// 	if (a->cursorR < 0) rNeg = 4;

// 	for (int i = 0; i < 2; i++) {
// 		shadowOAM[ROWCURS + i].attr0 = 16;
// 		shadowOAM[ROWCURS + i].attr1 = ATTR1_SIZE8 | (224 - (i*8));
// 		shadowOAM[ROWCURS + i].attr2 = SPRITEOFFSET16(rNeg, getDigit(abs(a->mapUp), i));	
// 	}

// 	// draw col values
// 	for (int i = 0; i < 2; i++) {
// 		shadowOAM[COLNUMS + i].attr0 = 24;
// 		shadowOAM[COLNUMS + i].attr1 = ATTR1_SIZE8 | (176 - (i*8));
// 		shadowOAM[COLNUMS + i].attr2 = SPRITEOFFSET16(0, getDigit(a->tileC, i));	
// 	}

// 	int cNeg = 0;
// 	if (a->offsetC < 0) cNeg = 4;

// 	for (int i = 0; i < 2; i++) {
// 		shadowOAM[COLOFF + i].attr0 = 24;
// 		shadowOAM[COLOFF + i].attr1 = ATTR1_SIZE8 | (200 - (i*8));
// 		shadowOAM[COLOFF + i].attr2 = SPRITEOFFSET16(cNeg, getDigit(abs(a->cursorC), i));	
// 	}

// 	cNeg = 0;
// 	if (a->cursorC < 0) cNeg = 4;
// 	for (int i = 0; i < 2; i++) {
// 		shadowOAM[COLCURS + i].attr0 = 24;
// 		shadowOAM[COLCURS + i].attr1 = ATTR1_SIZE8 | (224 - (i*8));
// 		shadowOAM[COLCURS + i].attr2 = SPRITEOFFSET16(cNeg, getDigit(abs(a->mapDown), i));	
// 	}


// }

void drawPlayer() {

	if (player.aniDir != IDLE && (player.aniFrame == 0 || player.aniFrame == 2)) {
		shadowOAM[OAM_PLAYER].attr0 = (player.screenRow-1) | ATTR0_TALL;
	} else {
		shadowOAM[OAM_PLAYER].attr0 = player.screenRow | ATTR0_TALL;
	}
	if (player.aniDir == RIGHT) {
		shadowOAM[OAM_PLAYER].attr1 = ATTR1_SIZE32 | player.screenCol | ATTR1_HFLIP;
	} else {
		shadowOAM[OAM_PLAYER].attr1 = ATTR1_SIZE32 | player.screenCol;
	}
	shadowOAM[OAM_PLAYER].attr2 = SPRITEOFFSET16(0, 0);


	if (player.aniDir == IDLE) {
		dmaSpriteSheet(s_MayTiles, 0, 0, 0, 2, 2, 1);
		dmaSpriteSheet(s_MayTiles, 1, 0, 0, 4, 2, 1);
		dmaSpriteSheet(s_MayTiles, 2, 0, 0, 6, 2, 1);
	} else if (player.aniDir == DOWN) {
		if (player.aniFrame == 0 || player.aniFrame == 2) {
			dmaSpriteSheet(s_MayTiles, 0, 0, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 1, 0, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 2, 0, 0, 6, 2, 1);
		} else if (player.aniFrame == 1) {
			dmaSpriteSheet(s_MayTiles, 0, 2, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 1, 2, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 2, 2, 0, 6, 2, 1);
		} else if (player.aniFrame == 3) {
			dmaSpriteSheet(s_MayTiles, 0, 4, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 1, 4, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 2, 4, 0, 6, 2, 1);
		}	
	} else if (player.aniDir == UP) {
		if (player.aniFrame == 0 || player.aniFrame == 2) {
			dmaSpriteSheet(s_MayTiles, 3, 0, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 4, 0, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 5, 0, 0, 6, 2, 1);
		} else if (player.aniFrame == 1) {
			dmaSpriteSheet(s_MayTiles, 3, 2, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 4, 2, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 5, 2, 0, 6, 2, 1);
		} else if (player.aniFrame == 3) {
			dmaSpriteSheet(s_MayTiles, 3, 4, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 4, 4, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 5, 4, 0, 6, 2, 1);
		}
	} else if (player.aniDir == LEFT || player.aniDir == RIGHT) {
		if (player.aniFrame == 0 || player.aniFrame == 2) {
			dmaSpriteSheet(s_MayTiles, 6, 0, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 7, 0, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 8, 0, 0, 6, 2, 1);
		} else if (player.aniFrame == 1) {
			dmaSpriteSheet(s_MayTiles, 6, 2, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 7, 2, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 8, 2, 0, 6, 2, 1);
		} else if (player.aniFrame == 3) {
			dmaSpriteSheet(s_MayTiles, 6, 4, 0, 2, 2, 1);
			dmaSpriteSheet(s_MayTiles, 7, 4, 0, 4, 2, 1);
			dmaSpriteSheet(s_MayTiles, 8, 4, 0, 6, 2, 1);
		}
	}

	dmaSpriteSheet(s_MayTiles, 0, 6, 0, 8, 5, 1);
	shadowOAM[2].attr0 = 24 | ATTR0_SQUARE;
	shadowOAM[2].attr1 = ATTR1_SIZE8 | (224);
	shadowOAM[2].attr2 = SPRITEOFFSET16(0, 8 + player.aniFrame);

	
}

void animatePlayer(PLAYER* p) {

	if (p->aniCounter > 0) {
		if (p->aniCounter % 8 == 0) {
			if (p->aniFrame < 3) {
				p->aniFrame++;
			} else {
				p->aniFrame = 0;
			}
		}
		p->aniCounter--;
	} 

} 

void startPlayerAniCounter() {
	player.aniCounter = 32;
}


