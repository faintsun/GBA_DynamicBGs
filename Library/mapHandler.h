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
} AREAMAP;

// Variables
extern AREAMAP area;
extern const unsigned short* palette;

// Prototypes
void loadMap(const unsigned short*, const unsigned short, const unsigned short*, const unsigned short, 
			unsigned short, unsigned short, unsigned char, unsigned char);
void loadPalette(const unsigned short*);
void drawMap();
void initMap(int, int);
void worldToScreen(int, int, int, int);
void cursorReset();
void moveMapLeft();
void moveMapRight();
void moveMapUp();
void moveMapDown();
