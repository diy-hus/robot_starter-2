#include <stdlib.h>
#include <stdio.h>
#include <delay.h>
#include <glcd.h>
#include <font5x7.h>
//---------dinh nghia-------
#define TRIGGER PORTC.6
#define ECHO PINC.7
#define LED_1 PORTB.0
#define LED_2 PORTB.1
#define PWM_1 OCR1B
#define PWM_2 OCR1A
#define DIR_1 PORTD.6
#define DIR_2 PORTD.7
#define motor_1 1
#define motor_2 2
#define run_thuan 0
#define run_nguoc 1
#define in_1 PORTB.3
#define in_2 PORTB.4
#define button_adc PINB.7
#define CT_1 PIND.0
#define CT_2 PINA.7
#define CT_3 PINA.6
#define servo_1 PORTA.4
#define servo_2 PORTA.5
#define BL_Nokia PORTC.5
//---------khai bao bien------
int change, count, dem, RC_1,RC_2;
unsigned int en_1, en_2, en_3;
unsigned char k = 0x0;
float distance;
char buff[20];
unsigned int min_adc[4];
unsigned int max_adc[4];
unsigned char ngatu=0,nho=0;
unsigned char set_adc=0;
eeprom unsigned int nguong_adc[4];
interrupt [EXT_INT0] void ext_int0_isr(void)
{
en_1++;
}
// Su dung ngat ngoai thu hai cho encoder banh phai
// External Interrupt 1 service routine
interrupt [EXT_INT1] void ext_int1_isr(void)
{
en_2++;
}

// External Interrupt 2 service routine
// Su dung ngat ngoai thu ba cho encoder tay nang _ cencter
interrupt [EXT_INT2] void ext_int2_isr(void)
{
en_3++;
}
// Timer 0 overflow interrupt service routine
// su dung timer 0 de dieu khien servo
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Reinitialize Timer 0 value
TCNT0=0x9C; // chu ky 0.1ms
dem++;
if(dem==200) {dem = 0;} // servo chi hoat dong khi cap xung 20ms vao, dem den 200 thi reset
if(dem<RC_1){servo_1 = 1;} else{servo_1 = 0;}
if(dem<RC_2){servo_2 = 1;} else{servo_2=0;}
}
// Timer2 overflow interrupt service routine
// su dung timer 2 de tinh thoi gian truyen ve cua cam bien sieu am
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
// Reinitialize Timer2 value
TCNT2=0x9C;
if(count>0){count++;}
if(ECHO == 0 && change == 1)
   {
    distance = count*0.1*3.432*5; 
    count = 0;
    change = 0; 
   }
}