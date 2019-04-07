#define AREA_TILE_CBB 0
#define AREA_BG2_SBB 28

// Structs
typedef struct {
	unsigned short SCREEN_MAP_BG2[1024];
	unsigned short WORLD_TILES[8000];
	unsigned short WORLD_MAP_BG2[3500];
	int worldTileLen;
	unsigned short worldMapLen;
	unsigned short worldTileW;
	unsigned short worldTileH;
	unsigned short SBB_LOC;
	unsigned short CBB_LOC;
	int tileR;				
	int tileC;	
	int offsetR;
	int offsetC;
	int cursorR;
	int cursorC;
	int mapUp;
	int mapDown;
	int mapLeft;
	int mapRight;
} CURRENTMAP;

typedef struct {
	const unsigned short* tiles;
	unsigned short tlen;
	const unsigned short* map_BG2;
	unsigned short mlen;
	const unsigned short* pal;
	unsigned short tilew;
	unsigned short tileh;
} AREAMAP;


// Variables
extern CURRENTMAP area;
extern CURRENTMAP* CURRENT_AREA_P;
extern const unsigned short* palette;

// Prototypes
void initialize_mapHandler();
void loadMap(AREAMAP*, int, int);
void loadPalette(AREAMAP*);
void drawMap();
void worldToScreen(int, int, int, int);
void cursorReset();
void moveMapLeft();
void moveMapRight();
void moveMapUp();
void moveMapDown();