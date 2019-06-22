#include "spriteHandler.h"
#include "spriteSheet.h"
#include "../Library/myLib.h"

void dmaSpriteSheet(const unsigned short* spriteTiles, 
					int srcRow, int srcCol, 
					int dstRow, int dstCol, 
					int width, int height) {
	for (int i = 0; i < height; i++) {
		DMANow(	3, 	
				&spriteTiles[OFFSET((srcRow*8) + (8*i), (srcCol*8*2), 64)], 
				&CHARBLOCK_SPRITE[OFFSET((dstRow*8) + (8*i), (dstCol*8*2), 64)], 
				width*8*2 );
	}
}


void setSpritePal(const unsigned short* pal) {
		DMANow(3, pal, SPRITE_PALETTE, 256);
}


