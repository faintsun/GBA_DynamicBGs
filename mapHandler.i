# 1 "mapHandler.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "mapHandler.c"
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

void initMap(int r, int c);
void loadMap(const unsigned short*, const unsigned short, const unsigned short*, const unsigned short, unsigned short, unsigned short);
void moveMapLeft();
void moveMapRight();
# 2 "mapHandler.c" 2
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
# 3 "mapHandler.c" 2

unsigned short SCREEN_MAP[1024];
unsigned short WORLD_TILES[8000];
unsigned short WORLD_MAP[2500];
unsigned short WORLD_TILE_LENGTH;
unsigned short WORLD_MAP_LENGTH;
unsigned short WORLD_MAP_TILE_WIDTH;
unsigned short WORLD_MAP_TILE_HEIGHT;
int TILE_COL;
int TILE_ROW;
int TILE_COL_OFFSET;
int TILE_ROW_OFFSET;


void loadMap(const unsigned short* tiles, const unsigned short tlen,
    const unsigned short* map, const unsigned short mlen,
    unsigned short tilew, unsigned short tileh) {

 WORLD_TILE_LENGTH = tlen;
 WORLD_MAP_LENGTH = mlen;
 WORLD_MAP_TILE_WIDTH = tilew;
 WORLD_MAP_TILE_HEIGHT = tileh;
 DMANow(3, tiles, WORLD_TILES, tlen/2);
 DMANow(3, map, WORLD_MAP, mlen/2);


}


void initMap(int r, int c) {


 for (int i = 0; i < (160 / 8); i++) {
  DMANow(3, &WORLD_MAP[((i + r)*(WORLD_MAP_TILE_WIDTH)+(0 + c))], &SCREEN_MAP[((i)*(32)+(0))], 32);
 }
 TILE_ROW = r;
 TILE_COL = c;
 TILE_ROW_OFFSET = 0;
 TILE_COL_OFFSET = 0;
}


void moveMapLeft() {

 TILE_COL_OFFSET -= 2;
 TILE_COL -= 2;

 int temp_col_offset = 0;



 if (TILE_COL_OFFSET < 0) {
  temp_col_offset = 32 + TILE_COL_OFFSET;

  for (int i = 0; i < (160 / 8); i++) {
   SCREEN_MAP[((i)*(32)+(temp_col_offset))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+(TILE_COL))];
   SCREEN_MAP[((i)*(32)+(temp_col_offset + 1))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+(TILE_COL + 1))];
  }


 } else {
  for (int i = 0; i < (160 / 8); i++) {
   SCREEN_MAP[((i)*(32)+(TILE_COL_OFFSET))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+(TILE_COL))];
   SCREEN_MAP[((i)*(32)+(TILE_COL_OFFSET + 1))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+(TILE_COL + 1))];
  }
 }

 DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], WORLD_MAP_LENGTH/2);

}


void moveMapRight() {

 TILE_COL_OFFSET += 2;
 TILE_COL += 2;

 int temp_col_offset = 0;



 if (TILE_COL_OFFSET <= 0) {
  temp_col_offset = 32 + TILE_COL_OFFSET;

  for (int i = 0; i < (160 / 8); i++) {
  SCREEN_MAP[((i)*(32)+(temp_col_offset - 2))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+((240 / 8) + TILE_COL))];
  SCREEN_MAP[((i)*(32)+(temp_col_offset - 1))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+((240 / 8) + TILE_COL + 1))];

  }


 } else {
  for (int i = 0; i < (160 / 8); i++) {
  SCREEN_MAP[((i)*(32)+(TILE_COL_OFFSET - 2))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+((240 / 8) + TILE_COL))];
  SCREEN_MAP[((i)*(32)+(TILE_COL_OFFSET - 1))] = WORLD_MAP[((i)*(WORLD_MAP_TILE_WIDTH)+((240 / 8) + TILE_COL + 1))];

  }
 }
# 113 "mapHandler.c"
 DMANow(3, SCREEN_MAP, &((screenblock *)0x6000000)[26], WORLD_MAP_LENGTH/2);

}
