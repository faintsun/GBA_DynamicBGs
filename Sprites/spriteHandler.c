#include "spriteHandler.h"
#include "spriteSheet.h"
#include "../Library/myLib.h"

void dmaSpriteSheet(unsigned short * spriteTiles, int origRow, int origCol, int sheetRow, int sheetCol, int width, int height) {
	for (int i = 0; i < height; i++) {
			DMANow(3, &spriteTiles[OFFSET((origRow*8) + (8*i), (origCol*8*2), 64)], &CHARBLOCK_SPRITE[OFFSET((sheetRow*8) + (8*i), (sheetCol*8*2), 64)], width*8*2);
	}
}

void setSpriteTiles(unsigned short* tiles) {
	DMANow(3, tiles, &CHARBLOCKBASE[4], spriteSheetTilesLen/2);
}

void setSpritePal(const unsigned short* pal) {
		DMANow(3, pal, SPRITE_PALETTE, 256);
}


