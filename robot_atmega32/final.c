/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 7/30/2017
Author  : 
Company : 
Comments: 


Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/
unsigned char Code_tay_cam1 = 0x89;
#include <mega32a.h>
#include <dinh_nghia.h>
#include <khoi_tao.h>
#include <thu_phat.h>
#include <dong_co.h>


void main(void)
{
Init_System();
RF_Config();
RF_Init();
LED_1=0;
LED_2=1;
glcd_moveto(0,0);
glcd_clear();
BL_Nokia = 0;
while (1)
      {
        if(CT_1==0){LED_2=!LED_2;LED_1=!LED_1;}
        RX_Mode();
        if(IRQ==0)                      
            {                          
               
                RF_RX_Read();      
                glcd_moveto(0,0);
                glcd_outtext("A_L:");   
                glcd_moveto(30,0);
                itoa(receive.analog_l, buff);
                glcd_outtext(buff);
                glcd_moveto(45,0); 
                glcd_outtext("A_R:"); 
                glcd_moveto(75,0);             
                itoa(receive.analog_r, buff);
                glcd_outtext(buff);
                glcd_moveto(0,20);
                glcd_outtext("D_L:");   
                glcd_moveto(30,20);
                itoa(receive.digital_l, buff);
                glcd_outtext(buff);
                glcd_moveto(45,20);
                glcd_outtext("D_R:");   
                glcd_moveto(75,20);
                itoa(receive.digital_r, buff);
                glcd_outtext(buff);
                glcd_moveto(0,36);
                glcd_outtext("-- DIY-HUS --");
                //-------------analog ben trai-----------
                if (receive.analog_l ==1)   {di_tien();}
                if (receive.analog_l ==2)   {di_lui();}
                if (receive.analog_l ==3)   {re_trai();}
                if (receive.analog_l ==4)   {re_phai();}
                if (receive.analog_l ==0)   {dung_xe();} 
                //-------------analog ben phai----------- 
                if (receive.analog_r ==1)   {tay_nang();}
                if (receive.analog_r ==2)   {tay_ha();}
                if (receive.analog_r ==3)   {tay_ha();}
                if (receive.analog_r ==4)   {tay_nang();}
                if (receive.analog_r ==0)   {dung_tay();}
                //-------------digital ben trai----------- 
                if (receive.digital_l ==1)   {RC1=23;}
                if (receive.digital_l ==2)   {RC1=23;}
                if (receive.digital_l ==3)   {RC1=23;}
                if (receive.digital_l ==4)   {RC1=23;}
                if (receive.digital_l ==0)   {RC1=18;} 
                //-------------digital ben phai----------- 
                if (receive.digital_r ==1)   {RC2=23;}
                if (receive.digital_r ==2)   {RC2=23;}
                if (receive.digital_r ==3)   {RC2=23;}
                if (receive.digital_r ==4)   {RC2=23;}
                if (receive.digital_r ==0)   {RC2=18;} 
               // delay_ms(1); 
            }     
      }
}
