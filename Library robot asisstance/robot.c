unsigned char Code_tay_cam1 = 0xB5;
#include <mega32a.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
#include "define.c"
#include "init.c"
#include "dong_co.c"
#include "rf.c"
void main(void)
{
init();
start_servo();
delay_ms(500);
//stop_servo();
RF_Init();
RF_Config();
RX_Mode();
steering=16;
while (1)
    {
     RX_Mode();
     if(IRQ==0)
        {
            led=!led;
            RF_RX_Read(); 
                if (receive.analog_l ==128)                                 {dung_yen();}
                if (receive.analog_l >128)                                  {di_thang(receive.analog_l);}
                if (receive.analog_l <128)                                  {di_lui(receive.analog_l);}
                if (receive.analog_r ==128)                                 {steering=16;}
                //------------------------------------
                if ((receive.analog_r >=128)&(receive.analog_r <=148))      {steering=17;}
                if ((receive.analog_r >=149)&(receive.analog_r <=170))      {steering=18;}
                if ((receive.analog_r >=171)&(receive.analog_r <=190))      {steering=19;}  
                if ((receive.analog_r >=191)&(receive.analog_r <=210))      {steering=20;}
                if ((receive.analog_r >=211)&(receive.analog_r <=230))      {steering=21;} 
                if (receive.analog_r >=231)                                 {steering=22;}
                //------------------------------------
                if ((receive.analog_r >=111)&(receive.analog_r <=127))      {steering=15;}
                if ((receive.analog_r >=91)&(receive.analog_r <=110))       {steering=14;}
                if ((receive.analog_r >=71)&(receive.analog_r <=90))        {steering=13;}  
                if ((receive.analog_r >=51)&(receive.analog_r <=70))        {steering=12;}
                if ((receive.analog_r >=21)&(receive.analog_r <=50))        {steering=11;} 
                if (receive.analog_r <=20)                                  {steering=10;}
                if (receive.digital_r ==1)                                  {ban();}    
        }

}
} 
