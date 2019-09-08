unsigned char Code_tay_cam1 = 0xB5;
#include <mega8.h>
#include "INIT.h"
#include "RF.h"
#include "DC.h"
#include <stdlib.h>

void main(void)
{
Init_System();
RF_Config();
RF_Init();
control_motor(2,1,0);              
control_motor(1,1,0);
glcd_moveto(0,0);
delay_ms(300);
glcd_clear();
BL_Nokia = 0;
RC=16;
while (1)
      {    
        RX_Mode();
        if(IRQ==0)                      
            {                          
                LED=!LED;
                glcd_clear();
                RF_RX_Read();      
                glcd_moveto(0,0); 
                itoa(receive.analog_l, glcd_buff);
                glcd_outtext(glcd_buff);
                glcd_moveto(20,0);              
                itoa(receive.analog_r, glcd_buff);
                glcd_outtext(glcd_buff);
                glcd_moveto(0,20);
                itoa(receive.digital_l, glcd_buff);
                glcd_outtext(glcd_buff);
                glcd_moveto(20,20);
                itoa(receive.digital_r, glcd_buff);
                glcd_outtext(glcd_buff);   
               
                if (receive.analog_l ==128)   {
                    control_motor(2,0,0);              
                    control_motor(1,1,0);} 
                     
                if (receive.analog_l >128)   {tien(receive.analog_l);}
                if (receive.analog_l <128)   {lui(receive.analog_l);}
            }
      }
}
