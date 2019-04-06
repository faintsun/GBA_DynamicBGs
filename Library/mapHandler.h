// Structs
typedef struct {
	unsigned short SCREEN_MAP[1024];
	unsigned short WORLD_TILES[8000];
	unsigned short WORLD_MAP[3500];
	unsigned short worldTileLen;
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
	const u16* tiles;
	u16 tlen;
	const u16* map;
	u16 mlen;
	u16 tilew;
	u16 tileh;
	u8 cbb;
	u8 sbb;
} AREAMAP;

// Variables
extern CURRENTMAP area;
extern const unsigned short* palette;

// Prototypes
void loadMap(AREAMAP*, int, int);
void loadPalette(const unsigned short*);
void drawMap();
void worldToScreen(int, int, int, int);
void cursorReset();
void moveMapLeft();
void moveMapRight();
void moveMapUp();
void moveMapDown();