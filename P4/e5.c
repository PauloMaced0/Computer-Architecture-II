
#include <detpic32.h>

int main(void)
{
    TRISB = TRISB & 0x80F0; // RB8-14 7 segment display and sw0-3 as output
    TRISD = TRISD & 0xFF9F; // RD5-6(ctnl_disp_l,ctnl_disp_l) as output

    LATD = (LATD & 0xFFDF) & ~(1 << 5);  // Same as LATDbits.LATD5 = 0
    LATD = (LATD & 0xFFBF) | (1 << 6); // Same as LATDbits.LATD6 = 1
    
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0xFF, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    int i;
    while (1)
    {
        PORTB = PORTB & 0xFFF0; // reset sw0-3
        for (i = 0; i < sizeof(disp7Scodes)/sizeof(char); i++){
            if ((PORTB & 0x000F) == i){
                LATB = (LATB & 0x80FF) | (disp7Scodes[i] << 8);
            }
        }
    }
    return 0;
}
