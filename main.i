# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"

# 1 "main.h" 1
# 3 "main.c" 2
# 1 "myLib.h" 1



typedef unsigned short u16;
# 46 "myLib.h"
extern unsigned short *videoBuffer;

extern unsigned short *frontBuffer;
extern unsigned short *backBuffer;



void loadPalette(const unsigned short* palette);
void initialize();

void waitForVblank();
void flipPage();

void fillScreen(unsigned short color);
void setPixel(int, int, unsigned short);


void drawBackgroundImage3(const unsigned short * image);
# 84 "myLib.h"
extern unsigned int oldButtons;
extern unsigned int buttons;
# 94 "myLib.h"
void DMANow(int channel, volatile const void* source, volatile const void* destination, unsigned int control);






typedef volatile struct
{
        volatile const void *src;
        volatile void *dst;
        volatile unsigned int cnt;
} DMA;

extern DMA *dma;
# 223 "myLib.h"
typedef struct { u16 tileimg[8192]; } charblock;
typedef struct { u16 tilemap[1024]; } screenblock;
# 281 "myLib.h"
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
# 4 "main.c" 2
# 1 "house.h" 1
# 22 "house.h"
extern const unsigned short houseTiles[896];


extern const unsigned short houseMap[1024];


extern const unsigned short housePal[256];
# 5 "main.c" 2
# 1 "mapHandler.h" 1

extern unsigned short SCREEN_MAP[1024];
extern unsigned short WORLD_TILES[8000];
extern unsigned short WORLD_MAP[2500];
extern unsigned short WORLD_TILE_LENGTH;
extern unsigned short WORLD_MAP_LENGTH;
extern unsigned short WORLD_MAP_TILE_WIDTH;
extern unsigned short WORLD_MAP_TILE_HEIGHT;
extern unsigned short TILE_COL;
extern unsigned short TILE_ROW;

void initMap(int r, int c);
void loadMap(const unsigned short*, const unsigned short, const unsigned short*, const unsigned short, unsigned short, unsigned short);
void moveMapLeft();
void moveMapRight();
# 6 "main.c" 2


# 1 "bg1.h" 1
# 22 "bg1.h"
extern const unsigned short bg1Tiles[176];


extern const unsigned short bg1Map[1024];


extern const unsigned short bg1Pal[16];
# 9 "main.c" 2
# 1 "bg2.h" 1
# 22 "bg2.h"
extern const unsigned short bg2Tiles[48];


extern const unsigned short bg2Map[4096];


extern const unsigned short bg2Pal[16];
# 10 "main.c" 2
# 1 "littleroot.h" 1
# 22 "littleroot.h"
extern const unsigned short littlerootTiles[6592];


extern const unsigned short littlerootMap[2112];


extern const unsigned short littlerootPal[256];
# 11 "main.c" 2
# 1 "littleroot256.h" 1
# 22 "littleroot256.h"
extern const unsigned short littleroot256Tiles[4800];


extern const unsigned short littleroot256Map[1024];


extern const unsigned short littleroot256Pal[256];
# 12 "main.c" 2


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
   for (int i = 0; i < (160 / 8); i++) {
    SCREEN_MAP[((i)*(32)+(TILE_COL - 2))] = littlerootMap[((i)*(WORLD_MAP_TILE_WIDTH)+((240 / 8) + TILE_COL))];
    SCREEN_MAP[((i)*(32)+(TILE_COL - 1))] = littlerootMap[((i)*(WORLD_MAP_TILE_WIDTH)+((240 / 8) + TILE_COL + 1))];
   }
  }
  delayRightMove = 0;
  DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], 2048/2);
 }

  updateScreenLocations();

  waitForVblank();
  waitForVblank();
  waitForVblank();

 }

}



void initMode0() {

 *(unsigned short *)0x4000000 = 0 | (1<<10);
 *(volatile unsigned short*)0x400000C = 0 << 2 | 26 << 8 | 0<<14 | 1 << 7;

 loadPalette(littlerootPal);
 loadMap(littlerootTiles, 13184, littlerootMap, 4224, 48, 44);

 DMANow(3, WORLD_TILES, &((charblock *)0x6000000)[0], WORLD_TILE_LENGTH/2);

 initMap(0, 0);

 DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], WORLD_MAP_LENGTH/2);


}



void buttonHandler() {
 oldButtons = buttons;
 buttons = *(volatile unsigned int *)0x04000130;

 if((~(*(volatile unsigned int *)0x04000130) & ((1<<4)))) {

  if (TILE_COL < WORLD_MAP_TILE_WIDTH - (240 / 8)) {
   moving = 1;
   dir = RIGHT;
   TILE_COL += 2;
   delayRightMove = 1;
  }



 }
 if((~(*(volatile unsigned int *)0x04000130) & ((1<<5)))) {
  if (TILE_COL > 0) {
   moving = 1;
   dir = LEFT;


   moveMapLeft(TILE_COL);

   TILE_COL -= 2;

  DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], 2048/2);


  }
 }
 if((~(*(volatile unsigned int *)0x04000130) & ((1<<7)))) {
  moving = 1;
  dir = DOWN;
  TILE_ROW++;
  if (TILE_ROW > 6) {
   DMANow(3, &littlerootMap[((160/8 + TILE_ROW)*(32)+(0))], &SCREEN_MAP[((TILE_ROW - 6)*(32)+(0))], 32);
   DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], 4224/2);
  }
 }
 if((~(*(volatile unsigned int *)0x04000130) & ((1<<6)))) {
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






 *(volatile unsigned short *)0x04000018 = hOff;
 *(volatile unsigned short *)0x0400001A = vOff;
}
