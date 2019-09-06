void control_motor(unsigned char motor,unsigned char dir_motor, unsigned char speed)  
{
    switch(motor)
    {
        case 1:
        {   if(dir_motor==0)
            {      
             DIR_1 =  dir_motor;
             PWM_1 = speed;  
             break;
            }
            else
            {
             DIR_1 =  dir_motor;
             PWM_1 = speed;  
             break;
            }
        } 
        case 2:
        {         
           
            if(dir_motor==0)
            {      
             DIR_2 =  dir_motor;
             PWM_2 = speed;  
             break;
            }
            else
            {
             DIR_2 =  dir_motor;
             PWM_2 = speed;  
             break;
            }
        }    
      
    }
}
void di_tien();
void di_tien()
    {
    control_motor(1,0,150);
    control_motor(2,0,150);
    }  
void di_lui();
void di_lui()
    {
    control_motor(1,1,150);
    control_motor(2,1,150);
    }
void dung_xe();
void dung_xe()
    {
    control_motor(1,0,0);
    control_motor(2,0,0);
    }
void re_trai();
void re_trai()
    {
    control_motor(1,1,150);
    control_motor(2,0,150);
    }
void re_phai();
void re_phai()
    {
    control_motor(1,0,150);
    control_motor(2,1,150);
    }
void tay_nang();
void tay_nang()
    {
    in_1 = 0;
    in_2 = 1;
    } 
void tay_ha();
void tay_ha()
    {
    in_1 = 1;
    in_2 = 0;
    }  
void dung_tay();
void dung_tay()
    {
    in_1 = 0;
    in_2 = 0;
    } 

