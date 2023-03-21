/**
  @Generated Pin Manager Header File

  @Company:
    Microchip Technology Inc.

  @File Name:
    pin_manager.h

  @Summary:
    This is the Pin Manager file generated using PIC10 / PIC12 / PIC16 / PIC18 MCUs

  @Description
    This header file provides APIs for driver for .
    Generation Information :
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.8
        Device            :  PIC18F57Q84
        Driver Version    :  2.11
    The generated drivers are tested against the following:
        Compiler          :  XC8 2.36 and above
        MPLAB 	          :  MPLAB X 6.00	
*/

/*
    (c) 2018 Microchip Technology Inc. and its subsidiaries. 
    
    Subject to your compliance with these terms, you may use Microchip software and any 
    derivatives exclusively with Microchip products. It is your responsibility to comply with third party 
    license terms applicable to your use of third party software (including open source software) that 
    may accompany Microchip software.
    
    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER 
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY 
    IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS 
    FOR A PARTICULAR PURPOSE.
    
    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP 
    HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO 
    THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL 
    CLAIMS IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT 
    OF FEES, IF ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS 
    SOFTWARE.
*/

#ifndef PIN_MANAGER_H
#define PIN_MANAGER_H

/**
  Section: Included Files
*/

#include <xc.h>

#define INPUT   1
#define OUTPUT  0

#define HIGH    1
#define LOW     0

#define ANALOG      1
#define DIGITAL     0

#define PULL_UP_ENABLED      1
#define PULL_UP_DISABLED     0

// get/set Pot_R aliases
#define Pot_R_TRIS                 TRISAbits.TRISA0
#define Pot_R_LAT                  LATAbits.LATA0
#define Pot_R_PORT                 PORTAbits.RA0
#define Pot_R_WPU                  WPUAbits.WPUA0
#define Pot_R_OD                   ODCONAbits.ODCA0
#define Pot_R_ANS                  ANSELAbits.ANSELA0
#define Pot_R_SetHigh()            do { LATAbits.LATA0 = 1; } while(0)
#define Pot_R_SetLow()             do { LATAbits.LATA0 = 0; } while(0)
#define Pot_R_Toggle()             do { LATAbits.LATA0 = ~LATAbits.LATA0; } while(0)
#define Pot_R_GetValue()           PORTAbits.RA0
#define Pot_R_SetDigitalInput()    do { TRISAbits.TRISA0 = 1; } while(0)
#define Pot_R_SetDigitalOutput()   do { TRISAbits.TRISA0 = 0; } while(0)
#define Pot_R_SetPullup()          do { WPUAbits.WPUA0 = 1; } while(0)
#define Pot_R_ResetPullup()        do { WPUAbits.WPUA0 = 0; } while(0)
#define Pot_R_SetPushPull()        do { ODCONAbits.ODCA0 = 0; } while(0)
#define Pot_R_SetOpenDrain()       do { ODCONAbits.ODCA0 = 1; } while(0)
#define Pot_R_SetAnalogMode()      do { ANSELAbits.ANSELA0 = 1; } while(0)
#define Pot_R_SetDigitalMode()     do { ANSELAbits.ANSELA0 = 0; } while(0)

// get/set Pot_G aliases
#define Pot_G_TRIS                 TRISAbits.TRISA1
#define Pot_G_LAT                  LATAbits.LATA1
#define Pot_G_PORT                 PORTAbits.RA1
#define Pot_G_WPU                  WPUAbits.WPUA1
#define Pot_G_OD                   ODCONAbits.ODCA1
#define Pot_G_ANS                  ANSELAbits.ANSELA1
#define Pot_G_SetHigh()            do { LATAbits.LATA1 = 1; } while(0)
#define Pot_G_SetLow()             do { LATAbits.LATA1 = 0; } while(0)
#define Pot_G_Toggle()             do { LATAbits.LATA1 = ~LATAbits.LATA1; } while(0)
#define Pot_G_GetValue()           PORTAbits.RA1
#define Pot_G_SetDigitalInput()    do { TRISAbits.TRISA1 = 1; } while(0)
#define Pot_G_SetDigitalOutput()   do { TRISAbits.TRISA1 = 0; } while(0)
#define Pot_G_SetPullup()          do { WPUAbits.WPUA1 = 1; } while(0)
#define Pot_G_ResetPullup()        do { WPUAbits.WPUA1 = 0; } while(0)
#define Pot_G_SetPushPull()        do { ODCONAbits.ODCA1 = 0; } while(0)
#define Pot_G_SetOpenDrain()       do { ODCONAbits.ODCA1 = 1; } while(0)
#define Pot_G_SetAnalogMode()      do { ANSELAbits.ANSELA1 = 1; } while(0)
#define Pot_G_SetDigitalMode()     do { ANSELAbits.ANSELA1 = 0; } while(0)

// get/set Pot_B aliases
#define Pot_B_TRIS                 TRISAbits.TRISA2
#define Pot_B_LAT                  LATAbits.LATA2
#define Pot_B_PORT                 PORTAbits.RA2
#define Pot_B_WPU                  WPUAbits.WPUA2
#define Pot_B_OD                   ODCONAbits.ODCA2
#define Pot_B_ANS                  ANSELAbits.ANSELA2
#define Pot_B_SetHigh()            do { LATAbits.LATA2 = 1; } while(0)
#define Pot_B_SetLow()             do { LATAbits.LATA2 = 0; } while(0)
#define Pot_B_Toggle()             do { LATAbits.LATA2 = ~LATAbits.LATA2; } while(0)
#define Pot_B_GetValue()           PORTAbits.RA2
#define Pot_B_SetDigitalInput()    do { TRISAbits.TRISA2 = 1; } while(0)
#define Pot_B_SetDigitalOutput()   do { TRISAbits.TRISA2 = 0; } while(0)
#define Pot_B_SetPullup()          do { WPUAbits.WPUA2 = 1; } while(0)
#define Pot_B_ResetPullup()        do { WPUAbits.WPUA2 = 0; } while(0)
#define Pot_B_SetPushPull()        do { ODCONAbits.ODCA2 = 0; } while(0)
#define Pot_B_SetOpenDrain()       do { ODCONAbits.ODCA2 = 1; } while(0)
#define Pot_B_SetAnalogMode()      do { ANSELAbits.ANSELA2 = 1; } while(0)
#define Pot_B_SetDigitalMode()     do { ANSELAbits.ANSELA2 = 0; } while(0)

// get/set RD3 procedures
#define RD3_SetHigh()            do { LATDbits.LATD3 = 1; } while(0)
#define RD3_SetLow()             do { LATDbits.LATD3 = 0; } while(0)
#define RD3_Toggle()             do { LATDbits.LATD3 = ~LATDbits.LATD3; } while(0)
#define RD3_GetValue()              PORTDbits.RD3
#define RD3_SetDigitalInput()    do { TRISDbits.TRISD3 = 1; } while(0)
#define RD3_SetDigitalOutput()   do { TRISDbits.TRISD3 = 0; } while(0)
#define RD3_SetPullup()             do { WPUDbits.WPUD3 = 1; } while(0)
#define RD3_ResetPullup()           do { WPUDbits.WPUD3 = 0; } while(0)
#define RD3_SetAnalogMode()         do { ANSELDbits.ANSELD3 = 1; } while(0)
#define RD3_SetDigitalMode()        do { ANSELDbits.ANSELD3 = 0; } while(0)

// get/set RF1 procedures
#define RF1_SetHigh()            do { LATFbits.LATF1 = 1; } while(0)
#define RF1_SetLow()             do { LATFbits.LATF1 = 0; } while(0)
#define RF1_Toggle()             do { LATFbits.LATF1 = ~LATFbits.LATF1; } while(0)
#define RF1_GetValue()              PORTFbits.RF1
#define RF1_SetDigitalInput()    do { TRISFbits.TRISF1 = 1; } while(0)
#define RF1_SetDigitalOutput()   do { TRISFbits.TRISF1 = 0; } while(0)
#define RF1_SetPullup()             do { WPUFbits.WPUF1 = 1; } while(0)
#define RF1_ResetPullup()           do { WPUFbits.WPUF1 = 0; } while(0)
#define RF1_SetAnalogMode()         do { ANSELFbits.ANSELF1 = 1; } while(0)
#define RF1_SetDigitalMode()        do { ANSELFbits.ANSELF1 = 0; } while(0)

// get/set RF2 procedures
#define RF2_SetHigh()            do { LATFbits.LATF2 = 1; } while(0)
#define RF2_SetLow()             do { LATFbits.LATF2 = 0; } while(0)
#define RF2_Toggle()             do { LATFbits.LATF2 = ~LATFbits.LATF2; } while(0)
#define RF2_GetValue()              PORTFbits.RF2
#define RF2_SetDigitalInput()    do { TRISFbits.TRISF2 = 1; } while(0)
#define RF2_SetDigitalOutput()   do { TRISFbits.TRISF2 = 0; } while(0)
#define RF2_SetPullup()             do { WPUFbits.WPUF2 = 1; } while(0)
#define RF2_ResetPullup()           do { WPUFbits.WPUF2 = 0; } while(0)
#define RF2_SetAnalogMode()         do { ANSELFbits.ANSELF2 = 1; } while(0)
#define RF2_SetDigitalMode()        do { ANSELFbits.ANSELF2 = 0; } while(0)

// get/set Led_p aliases
#define Led_p_TRIS                 TRISFbits.TRISF3
#define Led_p_LAT                  LATFbits.LATF3
#define Led_p_PORT                 PORTFbits.RF3
#define Led_p_WPU                  WPUFbits.WPUF3
#define Led_p_OD                   ODCONFbits.ODCF3
#define Led_p_ANS                  ANSELFbits.ANSELF3
#define Led_p_SetHigh()            do { LATFbits.LATF3 = 1; } while(0)
#define Led_p_SetLow()             do { LATFbits.LATF3 = 0; } while(0)
#define Led_p_Toggle()             do { LATFbits.LATF3 = ~LATFbits.LATF3; } while(0)
#define Led_p_GetValue()           PORTFbits.RF3
#define Led_p_SetDigitalInput()    do { TRISFbits.TRISF3 = 1; } while(0)
#define Led_p_SetDigitalOutput()   do { TRISFbits.TRISF3 = 0; } while(0)
#define Led_p_SetPullup()          do { WPUFbits.WPUF3 = 1; } while(0)
#define Led_p_ResetPullup()        do { WPUFbits.WPUF3 = 0; } while(0)
#define Led_p_SetPushPull()        do { ODCONFbits.ODCF3 = 0; } while(0)
#define Led_p_SetOpenDrain()       do { ODCONFbits.ODCF3 = 1; } while(0)
#define Led_p_SetAnalogMode()      do { ANSELFbits.ANSELF3 = 1; } while(0)
#define Led_p_SetDigitalMode()     do { ANSELFbits.ANSELF3 = 0; } while(0)

/**
   @Param
    none
   @Returns
    none
   @Description
    GPIO and peripheral I/O initialization
   @Example
    PIN_MANAGER_Initialize();
 */
void PIN_MANAGER_Initialize (void);

/**
 * @Param
    none
 * @Returns
    none
 * @Description
    Interrupt on Change Handling routine
 * @Example
    PIN_MANAGER_IOC();
 */
void PIN_MANAGER_IOC(void);



#endif // PIN_MANAGER_H
/**
 End of File
*/