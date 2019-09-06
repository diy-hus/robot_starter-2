//void banh_1_tien()
//{
//    DIR_1 =  1;
//    PWM_1 = 0;      
//}
//void banh_1_lui()
//{
//    DIR_1 =  0;
//    PWM_1 = 1;      
//}
//void banh_1_dung()
//{
//    DIR_1 =  0;
//    PWM_1 = 0;      
//}
//void banh_2_tien()
//{
//    DIR_2 =  1;
//    PWM_2 = 0;      
//}
//void banh_2_lui()
//{
//    DIR_2 =  0;
//    PWM_2 = 1;      
//}
//void banh_2_dung()
//{
//    DIR_2 =  0;
//    PWM_2 = 0;      
//}
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
             PWM_1 = 255-speed;  
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
             PWM_2 = 255-speed;  
             break;
            }
        }    
      
    }
}
void di_tien();
void di_tien()
    {
    control_motor(1,0,200);
    control_motor(2,0,200);
    }  
void di_lui();
void di_lui()
    {
    control_motor(1,1,200);
    control_motor(2,1,200);
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
    control_motor(1,1,200);
    control_motor(2,0,200);
    }
void re_phai();
void re_phai()
    {
    control_motor(1,0,200);
    control_motor(2,1,200);
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
     
//void di_thang()
//{
//    banh_1_tien();
//    delay_ms(25);
//    banh_2_tien();
//}
//void di_nguoc()
//{
//    banh_1_lui();
//    delay_ms(25);  
//    banh_2_lui();
//    
//}
//void di_trai()
//{
//    banh_1_tien();
//    banh_2_lui(); 
//    delay_ms(25); 
//    
//}
//void di_phai()
//{
//    banh_1_lui(); 
//    delay_ms(25);
//    banh_2_tien();
//}
//void dung()
//{
//    banh_1_dung();
//    banh_2_dung();
//}