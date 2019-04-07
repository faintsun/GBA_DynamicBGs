#define mapArrayLength 2

extern AREAMAP *MAP_ARRAY[mapArrayLength];

typedef enum {
	LITTLEROOT_TOWN,
	DEWFORD_TOWN
} MAPNAME;

void initialize_mapList();

