#define CE   PORTC.0            //   out 1
#define SCK   PORTC.2            //   out 1
//#define IRQ  PORTC.4

/*********** PORTC ************/
/*********** PORTD ************/ 

#define MISO   PINC.4           //in p
#define CSN    PORTC.1         //   out 1
#define MOSI   PORTC.3          //   out 1
#define IRQ     PINC.5              //in p
//#include "NRF24L01.c"

#define DATA PIND.3      //in p
#define CMD PORTD.2      //out 1
#define ATT PORTD.1      //out 1
#define CLK PORTD.0      //out 1


// Dieu khien LED
#define Status          0x40;   // Set bit
#define Mode_program    0x04; // Set bit


//byte nhan Tay cam
#define Select  1 // nut Select Byte 4.0
#define L3      2 // nut Select Byte 4.1
#define R3      4 // nut Select Byte 4.2
#define Start   8 // nut Select Byte 4.3
#define Up      16 // nut Select Byte 4.4
#define Right   32 // nut Select Byte 4.5
#define Down    64 // nut Select Byte 4.6
#define Left    128 // nut Select Byte 4.7

#define L2      1 // nut Select Byte 5.0
#define R2      2 // nut Select Byte 5.1
#define L1      4 // nut Select Byte 5.2
#define R1      8 // nut Select Byte 5.3
#define Tamgiac 16 // nut Select Byte 5.4
#define Tron    32 // nut Select Byte 5.5
#define Nhan    64 // nut Select Byte 5.6
#define Vuong   128 // nut Select Byte 5.7  