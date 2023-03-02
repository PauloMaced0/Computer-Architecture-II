#include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}

int main(void)
{
    // TRISC = TRISC & 0xBFFF; // RC14 as output
    TRISC = TRISC & ~(1 << 14);
    // int n = 0;
    while (1)
    {
        // delay(500);
        // n = n == 0 ? 1 : 0;
        // LATCbits.LATC14 = n;
        LATC = LATC | (1 << 14);
        delay(500);
        LATC = LATC & ~(1 << 14);
        delay(500);
    }
    return 0;
}
