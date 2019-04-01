
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