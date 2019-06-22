// variables
unsigned int buttons;
unsigned int oldButtons;

int hOff = 0;
int vOff = 0;

OBJ_ATTR shadowOAM[128];
enum { OAM_PLAYER = 0 };
enum { IDLE, LEFT, RIGHT, UP, DOWN };

int dir = 0;
int moving = 0;
int dirTimer;

AREAMAP* currMap;


typedef struct {
	short worldCol;
	short worldRow;
	short screenCol;
	short screenRow;
	unsigned short width;
	unsigned short height;
	unsigned short aniFrame;
	unsigned short aniCounter;
	unsigned char aniDir;
} PLAYER;

PLAYER player;

// prototypes
void (*nextMove)();

void init();
void draw();
void updateScreenLocations();
void buttonHandler(CURRENTMAP*);
void cameraHandler();
void hideSprites();

void animatePlayer(PLAYER*);
void drawPlayer();
// void drawHelperNumbers(CURRENTMAP* a);


void startPlayerAniCounter();
