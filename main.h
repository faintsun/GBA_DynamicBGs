// variables
unsigned int buttons;
unsigned int oldButtons;

int hOff = 0;
int vOff = 0;

OBJ_ATTR shadowOAM[128];
enum { ROWLOC = 0, COLLOC = 1, ROWNUMS = 2, ROWOFF = 4, COLNUMS = 6, COLOFF = 8, ROWCURS = 10, COLCURS = 12 };

int dir = 0;
int moving = 0;
int dirTimer;

AREAMAP* currMap;

// prototypes
void (*nextMove)();

void init();
void draw();
void updateScreenLocations();
void buttonHandler();
void cameraHandler();
void hideSprites();

void drawHelperNumbers(CURRENTMAP* a);