#include <detpic32.h>

int main(void)
{
    TRISB = TRISB & 0x80FF; // RB8-14 7 segment display
    TRISD = TRISD & 0xFF9F; // RD5(ctnl_disp_l,ctnl_disp_l)

    LATD = (LATD & 0xFFDF) & ~(1 << 5); // Same as LATDbits.LATD5 = 0
    LATD = (LATD & 0xFFBF) | (1 << 6); // Same as LATDbits.LATD6 = 1

    while (1)
    {
        int c = getChar();
        if (c >= 0x61 && c <= 0x67)
        {
            LATB = (LATB & 0x80FF) | (c << 8);
        }
    }
    return 0;
}
