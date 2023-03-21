PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include <xc.inc>
#include "libreria.inc"

PSECT resetVect,class=CODE,reloc=2
    
resetVect:
    goto Main
        
    
PSECT CODE
 
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
	   

    CALL Delay_10us,1
  ;  CALL Delay_14us,1	
    NOP
    ; CALL Delay_20us,1
 
    


  
/******************************************************************************/    
    
Config_OSC:		;Configuración del oscilador Interno a una frecuencia de 8MHz
    BANKSEL OSCCON1
    MOVLW   0x60	;seleccionamos el bloque del  osc interno con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02	;seleccionamos una freciencoa de 4MHz
    MOVWF   OSCFRQ	
    RETURN
    
Config_Port:	  ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3
    BANKSEL PORTF
    CLRF    PORTF,1	;PORT = 0
    BSF	    LATF,3,1	;LAT<3> = 1 (Led OFF)
    CLRF    ANSELF,1	;ANSELF<7> = 0 (Port F digital)
    BCF	    TRISF,3,1	;TRISF<3> = 0 (RF3 como salida)
    
    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1
    CLRF    ANSELA,1
    BSF	    TRISA,3,1
    BSF	    WPUA,3,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3
    
    RETURN

END resetVect