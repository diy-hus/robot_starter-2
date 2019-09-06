unsigned char rjoyx,rjoyy,ljoyx,ljoyy,byte4,byte5;
unsigned char access(unsigned char tbyte);
unsigned char ready=0;
void read_data(void);

//access PS2 Gamepad
unsigned char access(unsigned char tbyte)
{
	unsigned char rbyte=0;
	unsigned char i;
	CMD = 1;
	CLK = 1;
	for(i=0;i<8;i++)
		{
			CMD=tbyte&0x01;
			delay_us(50);
			CLK=0; 
			delay_us(50);
			rbyte=(rbyte>>1)|(DATA<<7);
			CLK=1;
			tbyte=tbyte>>1;
		}
	delay_us(100);
	return rbyte;
}


void read_data(void)
{
ATT=0;               // Enable Joytick
access(0x01);       // >> dua ma 0x01 vao Joytick
access(0x42);      // >> dua ma 0x42 vao Joytick
access(0);
byte4   =   access(0);
byte5   =   access(0);
rjoyx   =   access(0);
rjoyy   =   access(0);
ljoyx   =   access(0);
ljoyy   =   access(0);
CMD=0;
ATT=1;
}
void reset_status(void)
	{
		byte4 = byte5 = 0xFF;
		rjoyx = rjoyy = ljoyx = ljoyy = 128;
	}
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{   TCNT0=0x90; //B8 tao tan so 150Hz
   if (ready==1)
      read_data();
}
void enter_config()
{
ATT=0;               // Enable Joytick
access(0x01);       // >> dua ma 0x01 vao Joytick
access(0x43);      // >> dua ma 0x42 vao Joytick
access(0x00);
access(0x01);
access(0x00);
CMD=0;
delay_ms(1);
ATT=1;
delay_ms(10);
}
void exit_config()
{
ATT=0;               // Enable Joytick
access(0x01);       // >> dua ma 0x01 vao Joytick
access(0x43);      // >> dua ma 0x42 vao Joytick
access(0x00);
access(0x00);
access(0x5A);
access(0x5A);
access(0x5A);
access(0x5A);
access(0x5A);
CMD=0;
delay_ms(1);
ATT=1;
delay_ms(10);
}
void change_analog()
{
ATT=0;              
access(0x01);      
access(0x44);
access(0x00);      
access(0x01);
access(0x03);
access(0x00);
access(0x00);
access(0x00);
access(0x00);
CMD=0;
delay_ms(1);
ATT=1;
delay_ms(10);
}