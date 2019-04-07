#include <stdlib.h>

#include "../Library/mapHandler.h"
#include "../Library/myLib.h"
#include "mapList.h"

#include "LittlerootTown/littleroot.h"
AREAMAP LittlerootTown;
#include "DewfordTown/dewford.h"
AREAMAP DewfordTown;

AREAMAP *MAP_ARRAY[mapArrayLength];

// there's probably a better way to do this but oh well

void initialize_mapList() {

	for (int i = 0; i < mapArrayLength; i++) {
    	MAP_ARRAY[i] = malloc(sizeof(AREAMAP));
    }

	// 0 - Littleroot
	LittlerootTown.tiles = littlerootTiles;
	LittlerootTown.tlen = littlerootTilesLen;
	LittlerootTown.map_BG2 = littlerootMap;
	LittlerootTown.mlen = littlerootMapLen;
	LittlerootTown.pal = littlerootPal;
	LittlerootTown.tilew = 68;
	LittlerootTown.tileh = 50;
	MAP_ARRAY[LITTLEROOT_TOWN] = &LittlerootTown;

	// 1 - Dewford
	DewfordTown.tiles = dewfordTiles;
	DewfordTown.tlen = dewfordTilesLen;
	DewfordTown.map_BG2 = dewfordMap;
	DewfordTown.mlen = dewfordMapLen;
	DewfordTown.pal = dewfordPal;
	DewfordTown.tilew = 50;
	DewfordTown.tileh = 48;
	MAP_ARRAY[DEWFORD_TOWN] = &DewfordTown;

	for (int i = 2; i < mapArrayLength; i++) {
		MAP_ARRAY[i] = &LittlerootTown;
	}

}







