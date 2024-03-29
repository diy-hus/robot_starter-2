void control_motor(unsigned char motor,unsigned char dir_motor,unsigned char speed){
    switch (motor){
        case 1:{
            if(dir_motor==0){
                DIR_1 = dir_motor;
                PWM_1 = speed;
                break;  
            }                                        
            else {
                DIR_1 = dir_motor;
                PWM_1 = 255 - speed;
                break;    
            }
        }
        case 2:{
            if(dir_motor==0){
                DIR_2 = dir_motor;
                PWM_2 = speed;
                break;  
            }
            else{
                DIR_2 = dir_motor;
                PWM_2 = 255 - speed;
                break; 
            }
        }
    }
}
void dung_yen(){
    control_motor(1,0,0);
    control_motor(2,0,0);
}

void di_lui(int speed){
    control_motor(1,1,255-speed);
    control_motor(2,1,255-speed);
}

void di_thang(int speed){
    control_motor(1,0,speed);
    control_motor(2,0,speed);
}

void start_servo()
{
DDRB.2=1;
DDRB.4=1;
DDRD.0=1;
DDRD.1=1;
DDRD.2=1;
DDRD.3=1;
DDRD.6=1;
}
void stop_servo()
{
DDRB.2=0;
DDRB.4=0;
DDRD.0=0;
DDRD.1=0;
DDRD.2=0;
DDRD.3=0;
DDRD.6=0;
}

void ban()
{
PORTD.2=1;
RC6=16;
delay_ms(600);
RC6=7;
}