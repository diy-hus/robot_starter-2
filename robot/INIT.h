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
#define servo1 PORTA.4
#define servo2 PORTA.5
#define BL_Nokia PORTC.5
#define chon_san PIND.1
#define CE PORTA.3     //out 1
#define CSN PORTA.6      //out 1
#define SCK PORTA.2       //out 1
#define MOSI PORTA.7      //out 1
#define MISO PINA.1       //in p
#define IRQ PINA.0        //in p
int change, count, dem, RC1,RC2;
unsigned int en_3;
float distance;
//--------
#include <stdio.h>
#include <delay.h>
#include <glcd.h>
#include <glcd_types.h>
#include <font5x7.h>
unsigned char glcd_buff[150];
unsigned char dem=0;
unsigned char RC1,RC2; 
//-----dieu khien servo-----
interrupt [TIM0_OVF] void timer0_ovf_isr(void)             
{

TCNT0=0x9C;                                                 
dem++;
if(dem==200){dem=0;}
if(dem<RC1){servo1=1;}else{servo1=0;}   
if(dem<RC2){servo2=1;}else{servo2=0;}   
}

void Init_System()
{
GLCDINIT_t glcd_init_data;
//===================================================
DDRB=(1<<DDB7) | (1<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
//===================================================
DDRC=(0<<DDC6) | (1<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
PORTC=(0<<PORTC6) | (1<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
//===================================================
DDRD=(1<<DDD7) | (1<<DDD6) | (0<<DDD5) | (0<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (1<<PORTD3) | (1<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
//===================================================

TCCR0=0x02;
TCNT0=0x9C;

TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

ASSR=0<<AS2;
TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (1<<TOIE0);

MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);

UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);

ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADFR) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

glcd_init_data.font=font5x7;
glcd_init_data.readxmem=NULL;
glcd_init_data.writexmem=NULL;
glcd_init_data.temp_coef=180;
glcd_init_data.bias=4;
glcd_init_data.vlcd=65;  
glcd_init(&glcd_init_data);

#asm("sei")   
RC1=10;
RC2=10;  
glcd_moveto(0,0);
glcd_outtext("Robotic");
glcd_moveto(28,13);
glcd_outtext("FOR");
glcd_moveto(35,24);
glcd_outtext("starters");
glcd_moveto(25,40);
glcd_outtext("DIY-HUS");
delay_ms(1000);
}