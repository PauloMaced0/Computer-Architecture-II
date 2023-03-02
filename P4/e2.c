#include <detpic32.h>

void delay(unsigned int ms){
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms);
}

int main(void){
    int count = 0;
    TRISE = TRISE & 0xFF87; // RE3-6
    while (1)
    {
        if (count >= 10){
            count = 0;
        }
        LATE = (LATE & 0xFF87) | (count << 3); 
        count++;
        delay(250); // 4Hz 
    }
    
    return 0;
}