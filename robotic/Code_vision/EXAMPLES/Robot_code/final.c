/*
 * bai5.c
 *
 * Created: 9/7/2017 5:57:05 PM
 * Author: Dr.Huy
 */
unsigned char Code_tay_cam=0xB5;
#include <mega8.h>
#include "INIT.c"
#include "RF.c"
#include "DC.c"
void main(void)
{Init_System();
 RF_Config();
 RF_Init();
 control_motor(2,1,0);
 control_motor(1,1,0);
 glcd_clear();
while (1)
    {
    RX_Mode();
    if(IRQ==0){ 
    LED=~LED;
          glcd_moveto(20,0);
          xx=RF_RX_Read();
          sprintf(glcd_buff,"%u",xx);
          glcd_outtext(glcd_buff);
          glcd_moveto(20,20);
             if(xx==1){
                 control_motor(2,1,255);
                 control_motor(1,0,255);
                 glcd_outtext("D");
                 }
             if(xx==3){
                 control_motor(2,0,255);
                 control_motor(1,1,255);
                 glcd_outtext("R");
             }
             if(xx==13){
                 control_motor(2,1,0);
                 control_motor(1,0,255);
                 glcd_outtext("left");
             }
             if(xx==15){
                 control_motor(2,1,255);
                 control_motor(1,1,0);
                 glcd_outtext("right");
                 }
             if(xx==23){
                 RC=25;
                 delay_ms(250);
                 RC=7;
             }
             if(xx==0){
                 control_motor(2,1,0);
                 control_motor(1,1,0);
                 glcd_clear();    
             }

    }
}
}