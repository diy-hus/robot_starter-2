char P_Add = 0x89;         // dia chi cua tay cam ( cam giong voi dia chi cua robot)
#include <mega8.h>
#include <delay.h>
#include <stdio.h>
#include <string.h>
#include "define.c"
#include "giai_ma_ps.c"
#include "nrf_code.c"
#include "khoi_tao.c"
char int_var=0; 
data_send data;

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
		if(ljoyy < 80)             {data.analog_l=1;} //analog trai tien
        else if(ljoyy > 170)        {data.analog_l=2;} //analog trai lui
        else if(ljoyx < 80)        {data.analog_l=3;} //analog trai sang trai
        else if(ljoyx > 170)        {data.analog_l=4;} //analog trai sang phai
        else                        {data.analog_l=0;} //gia tri o giua 
        if(rjoyy < 80)             {data.analog_r=1;} //analog phai tien
        else if(rjoyy > 170)        {data.analog_r=2;} //analog phai lui
        else if(rjoyx < 80)        {data.analog_r=3;} //analog phai sang trai
        else if(rjoyx > 170)        {data.analog_r=4;} //analog phai sang phai
        else                        {data.analog_r=0;} //gia tri o giua
        if((byte4&Up) == 0)         {data.digital_l=1;}
        else if((byte4&Left) == 0)  {data.digital_l=3;}
        else if((byte4&Down) == 0)  {data.digital_l=2;}
        else if((byte4&Right) == 0) {data.digital_l=4;}
        else                        {data.digital_l=0;}
        if((byte5&Tamgiac) == 0)    {data.digital_r=1;}
        else if((byte5&Tron) == 0)  {data.digital_r=4;}
        else if((byte5&Nhan) == 0)  {data.digital_r=2;}
        else if((byte5&Vuong) == 0) {data.digital_r=3;}
        else                        {data.digital_r=0;}
      /***************************************************/
        if((byte5&L1) == 0)         {data.digital=1;}
        else if((byte5&R1) == 0)    {data.digital=2;}
        else if((byte5&L2) == 0)    {data.digital=3;}
        else if((byte5&R2) == 0)    {data.digital=4;}
        else if((byte4&Select) == 0){data.digital=5;}
        else if((byte4&L3) == 0)    {data.digital=6;}
        else if((byte4&R3) == 0)    {data.digital=7;}
        else if((byte4&Start) == 0) {data.digital=8;}
        else                        {data.digital=0;}
      /**************************************************/
       RF_TX_send(P_Add,data);   // ham gui ma lenh den dia chi P_Add 
       delay_ms(1); 
      }
}        
