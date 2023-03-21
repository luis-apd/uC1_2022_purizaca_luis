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

// get/set Button aliases
#define Button_TRIS                 TRISAbits.TRISA3
#define Button_LAT                  LATAbits.LATA3
#define Button_PORT                 PORTAbits.RA3
#define Button_WPU                  WPUAbits.WPUA3
#define Button_OD                   ODCONAbits.ODCA3
#define Button_ANS                  ANSELAbits.ANSELA3
#define Button_SetHigh()            do { LATAbits.LATA3 = 1; } while(0)
#define Button_SetLow()             do { LATAbits.LATA3 = 0; } while(0)
#define Button_Toggle()             do { LATAbits.LATA3 = ~LATAbits.LATA3; } while(0)
#define Button_GetValue()           PORTAbits.RA3
#define Button_SetDigitalInput()    do { TRISAbits.TRISA3 = 1; } while(0)
#define Button_SetDigitalOutput()   do { TRISAbits.TRISA3 = 0; } while(0)
#define Button_SetPullup()          do { WPUAbits.WPUA3 = 1; } while(0)
#define Button_ResetPullup()        do { WPUAbits.WPUA3 = 0; } while(0)
#define Button_SetPushPull()        do { ODCONAbits.ODCA3 = 0; } while(0)
#define Button_SetOpenDrain()       do { ODCONAbits.ODCA3 = 1; } while(0)
#define Button_SetAnalogMode()      do { ANSELAbits.ANSELA3 = 1; } while(0)
#define Button_SetDigitalMode()     do { ANSELAbits.ANSELA3 = 0; } while(0)

// get/set RB1 procedures
#define RB1_SetHigh()            do { LATBbits.LATB1 = 1; } while(0)
#define RB1_SetLow()             do { LATBbits.LATB1 = 0; } while(0)
#define RB1_Toggle()             do { LATBbits.LATB1 = ~LATBbits.LATB1; } while(0)
#define RB1_GetValue()              PORTBbits.RB1
#define RB1_SetDigitalInput()    do { TRISBbits.TRISB1 = 1; } while(0)
#define RB1_SetDigitalOutput()   do { TRISBbits.TRISB1 = 0; } while(0)
#define RB1_SetPullup()             do { WPUBbits.WPUB1 = 1; } while(0)
#define RB1_ResetPullup()           do { WPUBbits.WPUB1 = 0; } while(0)
#define RB1_SetAnalogMode()         do { ANSELBbits.ANSELB1 = 1; } while(0)
#define RB1_SetDigitalMode()        do { ANSELBbits.ANSELB1 = 0; } while(0)

// get/set RB2 procedures
#define RB2_SetHigh()            do { LATBbits.LATB2 = 1; } while(0)
#define RB2_SetLow()             do { LATBbits.LATB2 = 0; } while(0)
#define RB2_Toggle()             do { LATBbits.LATB2 = ~LATBbits.LATB2; } while(0)
#define RB2_GetValue()              PORTBbits.RB2
#define RB2_SetDigitalInput()    do { TRISBbits.TRISB2 = 1; } while(0)
#define RB2_SetDigitalOutput()   do { TRISBbits.TRISB2 = 0; } while(0)
#define RB2_SetPullup()             do { WPUBbits.WPUB2 = 1; } while(0)
#define RB2_ResetPullup()           do { WPUBbits.WPUB2 = 0; } while(0)
#define RB2_SetAnalogMode()         do { ANSELBbits.ANSELB2 = 1; } while(0)
#define RB2_SetDigitalMode()        do { ANSELBbits.ANSELB2 = 0; } while(0)

// get/set Led_P aliases
#define Led_P_TRIS                 TRISFbits.TRISF3
#define Led_P_LAT                  LATFbits.LATF3
#define Led_P_PORT                 PORTFbits.RF3
#define Led_P_WPU                  WPUFbits.WPUF3
#define Led_P_OD                   ODCONFbits.ODCF3
#define Led_P_ANS                  ANSELFbits.ANSELF3
#define Led_P_SetHigh()            do { LATFbits.LATF3 = 1; } while(0)
#define Led_P_SetLow()             do { LATFbits.LATF3 = 0; } while(0)
#define Led_P_Toggle()             do { LATFbits.LATF3 = ~LATFbits.LATF3; } while(0)
#define Led_P_GetValue()           PORTFbits.RF3
#define Led_P_SetDigitalInput()    do { TRISFbits.TRISF3 = 1; } while(0)
#define Led_P_SetDigitalOutput()   do { TRISFbits.TRISF3 = 0; } while(0)
#define Led_P_SetPullup()          do { WPUFbits.WPUF3 = 1; } while(0)
#define Led_P_ResetPullup()        do { WPUFbits.WPUF3 = 0; } while(0)
#define Led_P_SetPushPull()        do { ODCONFbits.ODCF3 = 0; } while(0)
#define Led_P_SetOpenDrain()       do { ODCONFbits.ODCF3 = 1; } while(0)
#define Led_P_SetAnalogMode()      do { ANSELFbits.ANSELF3 = 1; } while(0)
#define Led_P_SetDigitalMode()     do { ANSELFbits.ANSELF3 = 0; } while(0)

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