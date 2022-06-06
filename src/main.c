#include <snes.h>
//#include "soundbank.h"

extern char snesfont;

// soundbank that are declared in soundbank.asm
extern char SOUNDBANK__0,SOUNDBANK__1;

//---------------------------------------------------------------------------------
int main(void) {
    // Initialize sound engine (take some time)
    spcBoot();

    // Initialize SNES
    consoleInit();

    // Set give soundbank
    spcSetBank(&SOUNDBANK__1);
    spcSetBank(&SOUNDBANK__0);

    // allocate around 10K of sound ram (39 256-byte blocks)
    spcAllocateSoundRegion(39);

    // Load music
    spcLoad(0);

    // Initialize text console with our font
    consoleInitText(0, 0, &snesfont);

    // Now Put in 16 color mode and disable Bgs except current
    setMode(BG_MODE1,0);
    bgSetDisable(1);
    bgSetDisable(2);

    // Draw a wonderfull text :P
    consoleDrawText(7, 10, "Hello World!");
    consoleDrawText(7, 14, "WELCOME TO SPC!");

    // Wait for nothing :P
    setScreenOn();

    // Play file from the beginning
    spcPlay(0);

    while(1) {
        WaitForVBlank();

        // Update music / sfx stream and wait vbl
        spcProcess();
    }
    return 0;
}

