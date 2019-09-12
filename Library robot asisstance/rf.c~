#define CE PORTD.4      //out 1
#define CSN PORTD.5      //out 1
#define SCK PORTD.3       //out 1
#define MOSI PORTD.6      //out 1
#define MISO PIND.2       //in p
#define IRQ PIND.7        //in p

typedef struct
{
    int analog_l; 
    int analog_r;
    int digital_l; 
    int digital_r;
}data;

data receive;

//--------------*---------------
unsigned char Code_tay_cam2 ;
unsigned char Code_tay_cam3;
unsigned char Code_tay_cam4;
unsigned char SPI_RW(unsigned char Buff);                                       //Function used for text moving
unsigned char SPI_Read(void);
void RF_Init();                                                                 //Function allow to Initialize RF device
void RF_Write(unsigned char Reg_Add, unsigned char Value);                      //Function to write a value to a register address
void RF_Command(unsigned char command);                                         //Function to write a command
void RF_Write_Address(unsigned char Address1, unsigned char Address2, unsigned char Address3, unsigned char Address4);         //Function to write TX and RX address
void RX_Mode();                                                          //Function to put nRF in RX mode
void RF_Config();                                                               //Function to config the nRF
void RF_RX_Read();                                                     //Function to read the data from RX FIFO
void RF_Write2(unsigned char Reg_Add, unsigned char Value);
void RF_Write3(unsigned char Reg_Add, unsigned char Value);



unsigned char SPI_RW(unsigned char Buff)
{
    unsigned char bit_ctr;
       for(bit_ctr=0;bit_ctr<8;bit_ctr++) // output 8-bit
       {
        MOSI = (Buff & 0x80);         // output 'uchar', MSB to MOSI    
        delay_us(5);
        Buff = (Buff << 1);           // shift next bit into MSB..
        SCK = 1;                      // Set SCK high..          
        delay_us(5);
        Buff |= MISO;                 // capture current MISO bit
        SCK = 0;                      // ..then set SCK low again
       }
    return(Buff);                     // return read uchar
}
unsigned char SPI_Read(void)
{   unsigned char Buff=0;
    unsigned char bit_ctr;
       for(bit_ctr=0;bit_ctr<8;bit_ctr++) // output 8-bit
       {
        delay_us(5);
        Buff = (Buff << 1);           // shift next bit into MSB..
        SCK = 1;                      // Set SCK high..          
        delay_us(5);
        Buff |= MISO;                 // capture current MISO bit
        SCK = 0;                      // ..then set SCK low again
       }
    return(Buff);                     // return read uchar
}
void RF_Init()                                                    //Function allow to Initialize RF device
{ 
    CE=1;
    delay_us(700);
    CE=0;
    CSN=1;
}
void RF_Write(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
{
    CSN=0;
    SPI_RW(0b00100000|Reg_Add);
    SPI_RW(Value);
    CSN=1;
    delay_us(10);
}
void RF_Write2(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
{
    CSN=0;
    SPI_RW(0b00100000|Reg_Add);
    SPI_RW(Value);
    SPI_RW(Value);
    SPI_RW(Value);
    SPI_RW(Value);
    SPI_RW(Value);
    CSN=1;
    delay_us(10);
}
void RF_Write3(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
{
    CSN=0;
    SPI_RW(0b00100000|Reg_Add); 
    SPI_RW(0x48);
    SPI_RW(0x48);
    SPI_RW(0x48);
    SPI_RW(0x48);  
    SPI_RW(Value);

  
    CSN=1;
    delay_us(10);
}
void RF_Command(unsigned char command)                            //Function to write a command
{
    CSN=0;
    SPI_RW(command);
    CSN=1;
    delay_us(10);
}
void RF_Write_Address(unsigned char Address1, unsigned char Address2, unsigned char Address3, unsigned char Address4)                      //Function to write TX and RX address
{
    CSN=0;
    RF_Write(0x03,0b00000011);
    CSN=1;
    delay_us(10);
    CSN=0;    
    RF_Write2(0x0A, Address1);
    RF_Write2(0x10, Address1);
    
    RF_Write3(0x0B, Address2);
    RF_Write3(0x10, Address2);
    
    RF_Write3(0x0C, Address3);
    RF_Write3(0x10, Address3);
    
    RF_Write3(0x0D, Address4);
    RF_Write3(0x10, Address4);
    
}

void RX_Mode()                                             //Function to put nRF in RX mode
{
    RF_Write(0x00,0b00011111);     //CONFIG 0x00
    CE=1;
}

void RF_Config()                                                  //Function to config the nRF
{
RF_Command(0b11100010);     //Flush RX

delay_us(10);
RF_Write(0x00,0b00011111);     //CONFIG 0x00

RF_Write(0x07,0b01111010);     //RF status
/*RF_Write(0x11,0b00100000);     //RX_PW_P0 0x11     Payload size
RF_Write(0x12,0b00100000);
RF_Write(0x13,0b00100000);
RF_Write(0x14,0b00100000);*/
RF_Write(0x1D, 0b00000100);
RF_Write(0x1C,0b00001111);     
RF_Write(0x05,0b00000010);
RF_Write_Address(Code_tay_cam1, Code_tay_cam2, Code_tay_cam3, Code_tay_cam4);
RF_Write(0x02,0b00001111);     //EX_RXADDR 0x02    enable data pipe 0;
RF_Write(0x01,0b00001111);     //EN_AA 0x01        enable auto-acknowledgment
RF_Write(0x04,0b00000000);     //SETUP_RETR 0x04   Setup retry time
}
void RF_RX_Read()                                         //Function to read the data from RX FIFO
{
   CE=0;
   CSN=1;
   delay_us(10);
   CSN=0;
   SPI_RW(0b01100001);
   delay_us(10); 
   receive.analog_l = SPI_Read();
   receive.analog_r = SPI_Read();
   receive.digital_l = SPI_Read();
   receive.digital_r = SPI_Read();
   CSN=1; 
   CE=1;
   RF_Write(0x07,0b01111110);  // Clear flag
   RF_Command(0b11100010);     //Flush RX
}