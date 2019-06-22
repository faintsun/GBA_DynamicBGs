# 1 "Sprites/spriteHandler.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "Sprites/spriteHandler.c"
# 1 "Sprites/spriteHandler.h" 1
void dmaSpriteSheet(unsigned short * , int origRow, int origCol, int sheetRow, int sheetCol, int width, int height);
void setSpriteTiles(unsigned short*);
void setSpritePal(const unsigned short*);
# 2 "Sprites/spriteHandler.c" 2
# 1 "Sprites/spriteSheet.h" 1
# 21 "Sprites/spriteSheet.h"
extern const unsigned short spriteSheetTiles[16384];


extern const unsigned short spriteSheetPal[256];
# 3 "Sprites/spriteHandler.c" 2
# 1 "Sprites/../Library/myLib.h" 1



typedef unsigned short u16;
typedef unsigned char u8;
# 47 "Sprites/../Library/myLib.h"
extern unsigned short *videoBuffer;

extern unsigned short *frontBuffer;
extern unsigned short *backBuffer;



void initialize();

void waitForVblank();
void flipPage();

void fillScreen(unsigned short color);
void setPixel(int, int, unsigned short);

void drawBackgroundImage3(const unsigned short * image);

int getDigit(int, int);
# 85 "Sprites/../Library/myLib.h"
extern unsigned int oldButtons;
extern unsigned int buttons;
# 96 "Sprites/../Library/myLib.h"
void DMANow(int channel, volatile const void* source, volatile const void* destination, unsigned int control);






typedef volatile struct
{
        volatile const void *src;
        volatile void *dst;
        volatile unsigned int cnt;
} DMA;

extern DMA *dma;
# 225 "Sprites/../Library/myLib.h"
typedef struct { u16 tileimg[8192]; } charblock;
typedef struct { u16 tilemap[1024]; } screenblock;
# 284 "Sprites/../Library/myLib.h"
typedef struct{
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
}OBJ_ATTR;

typedef struct {
    int row;
    int col;
} Sprite;
# 4 "Sprites/spriteHandler.c" 2

void dmaSpriteSheet(unsigned short * spriteTiles, int origRow, int origCol, int sheetRow, int sheetCol, int width, int height) {
 for (int i = 0; i < height; i++) {
   DMANow(3, &spriteTiles[(((origRow*8) + (8*i))*(64)+((origCol*8*2)))], &( (unsigned short*)0x6010000)[(((sheetRow*8) + (8*i))*(64)+((sheetCol*8*2)))], width*8*2);
 }
}

void setSpriteTiles(unsigned short* tiles) {
 DMANow(3, tiles, &((charblock *)0x6000000)[4], 32768/2);
}

void setSpritePal(const unsigned short* pal) {
  DMANow(3, pal, ((unsigned short*)(0x5000200)), 256);
}
