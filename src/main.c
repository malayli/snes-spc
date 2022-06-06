#include <snes.h>

extern char snesfont;

//---------------------------------------------------------------------------------
int main(void) {
    // Initialize SNES
    consoleInit();

    LoadSPC();

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

    while(1) {
        WaitForVBlank();
    }
    return 0;
}
