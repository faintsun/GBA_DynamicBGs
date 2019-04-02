
// extern unsigned short SCREEN_MAP[1024];
// extern unsigned short WORLD_TILES[8000];
// extern unsigned short WORLD_MAP[3500];
// extern unsigned short WORLD_TILE_LENGTH;
// extern unsigned short WORLD_MAP_LENGTH;
// extern unsigned short WORLD_MAP_TILE_WIDTH;
// extern unsigned short WORLD_MAP_TILE_HEIGHT;
// extern int* TILE_COL;				
// extern int* TILE_ROW;	
// extern int COL_CURSOR;
// extern int ROW_CURSOR;

typedef struct {
	unsigned short SCREEN_MAP[1024];
	unsigned short WORLD_TILES[8000];
	unsigned short WORLD_MAP[3500];
	unsigned short WORLD_TILE_LENGTH;
	unsigned short WORLD_MAP_LENGTH;
	unsigned short WORLD_MAP_TILE_WIDTH;
	unsigned short WORLD_MAP_TILE_HEIGHT;
	unsigned short SBB_LOC;
	unsigned short CBB_LOC;
	int TILE_COL;				
	int TILE_ROW;	
	int COL_CURSOR;
	int ROW_CURSOR;

} AREAMAP;

extern AREAMAP area;

void initMap(int r, int c);
void loadMap(const unsigned short*, const unsigned short, const unsigned short*, const unsigned short, 
			unsigned short, unsigned short, unsigned char, unsigned char);
void drawMap();
void worldToScreen(int, int, int, int);
void moveMapLeft();
void moveMapRight();
void moveMapUp();
void moveMapDown();