#include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}

int main(void)
{
    TRISB = TRISB & 0x80FF; // RB8-14 7 segment display
    TRISD = TRISD & 0xFF9F; // RD5(ctnl_disp_l,ctnl_disp_l)

    LATD = (LATD & 0xFFDF) | (1 << 5);  // Same as LATDbits.LATD5 = 1
    LATD = (LATD & 0xFFBF) & ~(1 << 6); // Same as LATDbits.LATD6 = 0
    int i;
    while (1)
    {
        int segment = 1;
        for (i = 0; i < 7; i++)
        {
            LATB = (LATB & 0x80FF) | (segment << 8);
            delay(500);
            segment = segment << 1;
        }
        // Toggle display
        LATD ^= 1 << 5;
        LATD ^= 1 << 6;
    }
    return 0;
}
