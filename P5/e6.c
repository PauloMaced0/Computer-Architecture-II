#include <detpic32.h>

void send2displays(unsigned char value)
{

    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0xFF, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    static char displayFlag = 0;
    if (displayFlag == 0)
    {
        LATD = LATD & ~(1 << 6);           // Same as LATDbits.LATD6 = 0
        LATD = (LATD & 0xFFDF) | (1 << 5); // Same as LATDbits.LATD5 = 1
        LATB = (LATB & 0x80FF) | (disp7Scodes[(value & 0x0F)] << 8);
    }
    else
    {
        LATD = (LATD & 0xFFBF) | (1 << 6); // Same as LATDbits.LATD6 = 1
        LATD = LATD & ~(1 << 5);           // Same as LATDbits.LATD5 = 0
        LATB = (LATB & 0x80FF) | (disp7Scodes[(value >> 4)] << 8);
    }
    displayFlag = displayFlag ^ 1;
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}

unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
}

int main(void)
{
    TRISB = (TRISB & 0x80FF) | 0x0001; // RB8-14 7 segment display as output and RB0(sw0) as input
    TRISD = TRISD & 0xFF9F;            // RD5-6(ctnl_disp_l,ctnl_disp_l) as output 
    TRISE = TRISE & 0xFF00;            // RE0-7 LEDS as output
    TRISC = TRISC & ~(1 << 14); // RC14(LED D11) as output

    // RD5-RD6 as output
    LATD = (LATD & 0xFF9F) | (3 << 5);
    unsigned int i = 0;
    signed char counter = 0;
    int refresh_counter = 1;
    int k = 0;
    int ON = 0;
    while (1)
    {
        send2displays(toBcd(counter));
        LATE = (LATE & 0xFF00) | counter;
        delay(10);                     // wait 10 ms (1/100Hz)
        i = (i + 1) % refresh_counter; // increment counter at 5Hz or decrement at 2Hz
        k = (k + 1) % 100; // 1 Hz 
        if (k == 0) ON++;
        if (ON == 5) LATC = LATC & ~(1 << 14);
        if (counter == 59 || counter == 0){
            LATC = LATC | (1 << 14);
            ON = 0;
        } 
        if (i == 0 && (PORTB & 0x0001) == 1)
        {
            refresh_counter = 20;
            counter++;
        }
        else if (i == 0 && (PORTB & 0x0000) == 0)
        {
            refresh_counter = 50;
            counter--;
        }
        else if (counter > 59 && (PORTB & 0x0001) == 1)
        {
            counter = 0;
        }
        else if (counter < 0 && (PORTB & 0x0000) == 0)
        {
            counter = 59;
        }
    }
    return 0;
}
