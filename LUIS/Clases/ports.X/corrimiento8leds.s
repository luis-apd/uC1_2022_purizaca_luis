PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include <xc.inc>
#include "delays.inc"
    
PSECT resetVect,class=CODE,reloc=2
    
resetVect:
    goto Main
    
PSECT CODE
 
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
/******************************************************************************/
	    
Led_off:
    BCF	    LATE,0,1	    ; Led off
    BCF	    LATE,1,1	    ; Led off
    BCF	    LATC,2,1
    BCF	    LATC,3,1
    BCF	    LATC,4,1
    BCF	    LATC,5,1
    BCF	    LATC,6,1
    BCF	    LATC,7,1 
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Led_off 
    CALL    Delay_25ms,1
    GOTO    Led_par
    
Led_par:
    BSF	    LATE,1,1	    ; Led on
    
    ;Desplazamiento
    Desp_par:
    BCF	    LATC,7,1	
    BSF	    LATC,0,1	    ; Led on
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,0,1
    BSF	    LATC,1,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,1,1
    BSF	    LATC,2,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,2,1
    BSF	    LATC,3,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,3,1
    BSF	    LATC,4,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,4,1
    BSF	    LATC,5,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,5,1
    BSF	    LATC,6,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
    BCF	    LATC,6,1
    BSF	    LATC,7,1	    ; Led on
    CALL    Delay_10ms,1
    ;CALL    Delay_250ms,1
    
   
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Led_par
    CALL    Delay_25ms,1
    
    
Led_imp:  
    BCF	    LATE,0,1	    ; Led off
    BCF	    LATE,1,1	    ; Led off
    BCF	    LATC,2,1
    BCF	    LATC,3,1
    BCF	    LATC,4,1
    BCF	    LATC,5,1
    BCF	    LATC,6,1
    BCF	    LATC,7,1 

    BSF	    LATE,0,1	    ; Led on
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Led_imp
    CALL    Delay_25ms,1
    GOTO    Led_off 
    
/******************************************************************************/    
/******************************************************************************/    
    
Config_OSC:		;Configuración del oscilador Interno a una frecuencia de 8MHz
    BANKSEL OSCCON1
    MOVLW   0x64	;seleccionamos el bloque del  osc interno con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02	;seleccionamos una freciencoa de 8MHz
    MOVWF   OSCFRQ	
    RETURN
    
Config_Port:	  ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3
  /*  BANKSEL PORTF
    CLRF    PORTF,1	;PORT = 0
    BSF	    LATF,3,1	;LAT<3> = 1 (Led OFF)
    CLRF    ANSELF,1	;ANSELF<7> = 0 (Port F digital)
    BCF	    TRISF,3,1	;TRISF<3> = 0 (RF3 como salida)
 */
    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1
    CLRF    ANSELA,1
    BSF	    TRISA,3,1
    BSF	    WPUA,3,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3
 
    ;config ports - PORTE
    BANKSEL PORTE	
    CLRF    PORTE,1	;PORT = 0
    BCF	    LATE,0,1	;LAT<0> = 1 (Led OFF)
    BCF	    LATE,1,1
    CLRF    ANSELE,1	;ANSELF<7> = 0 (Port F digital)
    BCF	    TRISE,0,1
    BCF	    TRISE,1,1	;TRISF<3> = 0 (RF3 como salida)
   
    ;config ports - PORTC
    BANKSEL PORTC
    CLRF    PORTC,1
    BCF	    LATC,0,1
    BCF	    LATC,1,1
    BCF	    LATC,2,1
    BCF	    LATC,3,1
    BCF	    LATC,4,1
    BCF	    LATC,5,1
    BCF	    LATC,6,1
    BCF	    LATC,7,1
    CLRF    ANSELC,1
    BCF     TRISC,0,1
    BCF	    TRISC,1,1
    BCF	    TRISC,2,1
    BCF	    TRISC,3,1
    BCF	    TRISC,4,1
    BCF	    TRISC,5,1
    BCF	    TRISC,6,1
    BCF	    TRISC,7,1
    
    RETURN

END resetVect


