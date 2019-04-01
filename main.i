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

# 1 "mapHandler.h" 1

extern unsigned short SCREEN_MAP[1024];
extern unsigned short WORLD_TILES[8000];
extern unsigned short WORLD_MAP[2500];
extern unsigned short WORLD_TILE_LENGTH;
extern unsigned short WORLD_MAP_LENGTH;
extern unsigned short WORLD_MAP_TILE_WIDTH;
extern unsigned short WORLD_MAP_TILE_HEIGHT;
extern int TILE_COL;
extern int TILE_ROW;
extern int TILE_COL_OFFSET;
extern int TILE_ROW_OFFSET;

extern char moving;
enum {LEFT, RIGHT, DOWN, UP};

void initMap(int r, int c);
void loadMap(const unsigned short*, const unsigned short, const unsigned short*, const unsigned short, unsigned short, unsigned short);
void moveMapLeft();
void moveMapRight();
void moveMapUp();
void moveMapDown();
# 6 "main.c" 2



# 1 "littleroot.h" 1
# 22 "littleroot.h"
extern const unsigned short littlerootTiles[6592];


extern const unsigned short littlerootMap[2112];


extern const unsigned short littlerootPal[256];
# 10 "main.c" 2



unsigned int buttons;
unsigned int oldButtons;

int hOff = 0;
int vOff = 0;


int dir = 0;
int dirTimer = 16;



extern const unsigned short* palette;




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

 *(unsigned short *)0x4000000 = 0 | (1<<10);
 *(volatile unsigned short*)0x400000C = 0 << 2 | 26 << 8 | 0<<14 | 1 << 7;

 loadPalette(littlerootPal);
 loadMap(littlerootTiles, 13184, littlerootMap, 4224, 48, 44);

 DMANow(3, WORLD_TILES, &((charblock *)0x6000000)[0], WORLD_TILE_LENGTH/2);

 initMap(0, 4);

 DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], WORLD_MAP_LENGTH/2);


}



void buttonHandler() {
 oldButtons = buttons;
 buttons = *(volatile unsigned int *)0x04000130;

 if (!nextMove) {
  if((~(*(volatile unsigned int *)0x04000130) & ((1<<4)))) {

   if (TILE_COL < WORLD_MAP_TILE_WIDTH - (240 / 8)) {
    nextMove = moveMapRight;
   }
  }

  if((~(*(volatile unsigned int *)0x04000130) & ((1<<5)))) {
   if (TILE_COL > 0) {
    nextMove = moveMapLeft;
    nextMove();
   }
  }
  if((~(*(volatile unsigned int *)0x04000130) & ((1<<7)))) {

  }
  if((~(*(volatile unsigned int *)0x04000130) & ((1<<6)))) {

  }
 }

}

void cameraHandler() {


 if (nextMove) {
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
   if (nextMove == moveMapRight) {
    nextMove();
   }
   nextMove = 0;
  }
 }
}



void updateScreenLocations() {






 *(volatile unsigned short *)0x04000018 = hOff;
 *(volatile unsigned short *)0x0400001A = vOff;
}
