PROCESSOR 18F57Q84
    
#include "bt_config.inc"	; config statements should precede file includes
#include <xc.inc>
   
PSECT resetVect,class=CODE,reloc=2
resetVect:

PSECT CODE
//    BCF PORTF,3,1
   
Main:
    CALL Config_OSC, 1
    CALL Config_PORT,1
    
Led_on:
    BANKSEL LATF
    BCF LATF,3,1	    //CLEAR
    //BSF LATF,3,1	    //SET
    GOTO Led_on

        ;SUBRUTINAS: 
Config_OSC:
    ; Configuracion del oscilador interno a una frecuencia de 8MHz
    BANKSEL OSCCON1  
    MOVLW 0x60		; Seleccionamos el bloque del oscilador interno con divisor=1
    MOVWF OSCCON1
    MOVLW 0x03		; Seleccionamos una frecuencia de 8MHz
    MOVWF OSCFRQ
    
RETURN
    
Config_PORT:		; PORT-LAT-ANSEL-TRIS	    LED:RF3	BUTTON:RA3
    BANKSEL PORTF
    CLRF PORTF,1	; PORTF = 0 
    BSF LATF,3,1	; LATF<3> =1
    CLRF ANSELF,1	; ANSELF<7:0> = 0 -PORT F DIGITAL
    BCF TRISF,3,1	; TRISF<3> = 0 - RF3 COMO SALIDA
    RETURN

END resetVect