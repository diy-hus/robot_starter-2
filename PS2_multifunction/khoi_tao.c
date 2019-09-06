void init_systeam (void);

void init_systeam (void)
{
PORTB=0x00;
DDRB=0xFF;

PORTC=0b00111111;
DDRC=0b00001111;

PORTD=0xFF;
DDRD=0b00000111;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 7.813 kHz
TCCR0=0x05;
TCNT0=0x00;

TIMSK=0x01;

UCSRB=0x00;

ACSR=0x80;
SFIOR=0x00;


ADCSRA=0x00;


SPCR=0x00;

GICR|=0x40;
MCUCR=0x02;
GIFR=0x40;

TWCR=0x00;
#asm("sei")
}
