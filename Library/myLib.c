#include "myLib.h"

#include <math.h>

unsigned short *videoBuffer = (u16 *)0x6000000;

unsigned short *frontBuffer = (u16 *)0x6000000;
unsigned short *backBuffer =  (u16 *)0x600A000;

DMA *dma = (DMA *)0x40000B0;




void DMANow(int channel, volatile const void* source, volatile const void* destination, unsigned int control) {
    dma[channel].src = source;
    dma[channel].dst = destination;
    dma[channel].cnt = DMA_ON | control;
}

void waitForVblank()
{
	while(SCANLINECOUNTER > 160);
	while(SCANLINECOUNTER < 160);
}


void flipPage()
{
    if(REG_DISPCTL & BACKBUFFER)
    {
        REG_DISPCTL &= ~BACKBUFFER;
        videoBuffer = backBuffer;
    }
    else
    {
        REG_DISPCTL |= BACKBUFFER;
        videoBuffer = frontBuffer;
    }
}

void fillScreen(unsigned short color) {

    volatile unsigned short c = color;
    DMANow(3, &c, videoBuffer, 38400 | DMA_SOURCE_FIXED);
}


void setPixel(int row, int col, unsigned short color) {

    videoBuffer[OFFSET(row, col, 240)] = color;
}

void drawBackgroundImage3(const unsigned short * image)
{
    DMANow(3, (unsigned short*)image, videoBuffer, (240*160));
}

int getDigit(int num, int digit) {
    num /= pow( 10, digit );
    return num % 10;
}