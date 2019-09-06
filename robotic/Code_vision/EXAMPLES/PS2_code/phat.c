#include <mega8.h>
#include <delay.h>
#include <stdio.h>
#include <string.h>
#include "define.c"
#include "giai_ma_ps.c"
char P_Add = 0x53;         // dia chi cua tay cam ( cam giong voi dia chi cua robot)
#include "nrf_code.c"
#include "khoi_tao.c"
 char int_var=0;

 unsigned char xx=0;
interrupt [EXT_INT0] void ext_int0_isr(void)
{  int_var=1; }

void main(void)
{
init_systeam();
 ready=0;
 reset_status();
 RF_Init();
 RF_Config();
 RX_Mode_Active();
 reset_status();           
 enter_config();
 change_analog();
 exit_config();          
 ready=1;
while (1)
  {  
  TX_Mode_Active();      
       if((rjoyy<80) &&(ljoyy>50) )          {xx=1;}    // phai len
  else if (rjoyy<30)                         {xx=2;}
  else if((rjoyy>170)&&(ljoyy<200))          {xx=3;}  // phai xuong
  else if (rjoyy>220)                        {xx=4;}
  else if((rjoyx<80) &&(ljoyx>50) )          {xx=5;}
  else if(rjoyx<30)                          {xx=6;}   // phai sang trai
  else if((rjoyx>170)&&(ljoyx<200))          {xx=7;}
  else if(rjoyx>220)                         {xx=8;} // phai sang phai
  else if((ljoyy<80) &&(rjoyy>50) )          {xx=9;}
  else if(ljoyy<30)                          {xx=10;}    // trai tien
  else if((ljoyy>170)&&(rjoyy<200))          {xx=11;}
  else if(ljoyy>220)                         {xx=12;}    // trai lui
  else if((ljoyx<80) &&(rjoyx>50) )          {xx=13;}
  else if(ljoyx<30)                          {xx=14;}    // trai trai 
  else if((ljoyx>170)&&(rjoyx<200))          {xx=15;}
  else if(ljoyx>220)                         {xx=16;}     // trai phai
  else if((byte4&Up) == 0)                   {xx=17;}
  else if((byte4&Left) == 0)                 {xx=18;}
  else if((byte4&Down) == 0)                 {xx=19;}
  else if((byte4&Right) == 0)                {xx=20;}
  else if((byte5&Tamgiac) == 0)              {xx=21;}
  else if((byte5&Tron) == 0)                 {xx=22;}
  else if((byte5&Nhan) == 0)                 {xx=23;}
  else if((byte5&Vuong) == 0)                {xx=24;}
  else if((byte5&L1) == 0)                   {xx=25;}
  else if((byte5&R1) == 0)                   {xx=26;}
  else if((byte5&L2) == 0)                   {xx=27;}
  else if((byte5&R2) == 0)                   {xx=28;}
  else if((byte4&Select) == 0)               {xx=29;}
  else if((byte4&L3) == 0)                   {xx=30;}
  else if((byte4&R3) == 0)                   {xx=31;}
  else if((byte4&Start) == 0)                {xx=32;}
  else                                       {xx=0;}
  RF_TX_send(P_Add,xx);   // ham gui ma lenh 
  delay_ms(1); 
    }
  }        
