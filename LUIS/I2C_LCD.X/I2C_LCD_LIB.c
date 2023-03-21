#include "I2C_LCD_LIB.h"
#include <xc.h>
#include <stdint.h>
#include "mcc_generated_files/mcc.h"
#include "mcc_generated_files/examples/i2c1_master_example.h"

#define LED_LCD_ON      0B000001000
#define LED_LCD_OFF     0B000000000

static uint8_t statusLED = LED_LCD_ON;
static uint8_t paramsLCD;
 
void PCF_Wr(uint8_t dato){
    I2C1_Write1ByteRegister(DIR_PCF, 0, dato|statusLED);
}

void loadPCF(uint8_t dato, uint8_t mode){

    switch(mode){
        case    _DATA_      : dato |=  (1<<LCD_RS); break;
        case    _COMMAND_   : dato &= ~(1<<LCD_RS); break;
    }
   
    PCF_Wr(dato);
    dato    |=  (1<<LCD_E);
    PCF_Wr(dato);
    dato    &= ~(1<<LCD_E);
    PCF_Wr(dato);
    __delay_us(30);
}

void sendDATA(uint8_t dato){
    uint8_t NibbleH, NibbleL;
    NibbleH = dato & 0xF0;
    NibbleL = (dato & 0x0F)<<4;
    loadPCF(NibbleH, _DATA_);
    loadPCF(NibbleL, _DATA_);
}

void sendCMD(uint8_t cmd){
    uint8_t NibbleH, NibbleL;
    NibbleH = cmd & 0xF0;
    NibbleL = (cmd & 0x0F)<<4;
    loadPCF(NibbleH, _COMMAND_);
    loadPCF(NibbleL, _COMMAND_);
}

void i2c_lcd_init(void){

    PCF_Wr(0x00);
    __delay_ms(15);
    sendCMD(0x03);
    __delay_us(4100);
    sendCMD(0x03);
    __delay_us(100);
    sendCMD(0x03);
    sendCMD(0x02); 
    
    sendCMD(_LCD_FUNTIONSET | _LCD_4BITMODE | _LCD_2LINE | _LCD_5x8DOTS);
    __delay_us(37);
    
    paramsLCD = _LCD_DISPLAY_ON | _LCD_CURSOR_ON | _LCD_BLINK_ON;
    sendCMD(_LCD_DISPLAYCONTROL | paramsLCD );
    __delay_us(37);
    
    sendCMD(_LCD_CLEARDISPLAY);
    __delay_ms(2);    

}

void i2c_lcd_write(uint8_t letra){
    sendDATA(letra);
}

void i2c_lcd_command(uint8_t cmd){
    sendCMD(cmd);
}

void i2c_lcd_text(char *str){
    
    while(*str){
        sendDATA(*str);
        str++;
    }
}

void i2c_lcd_set_cursor(uint8_t row, uint8_t col);