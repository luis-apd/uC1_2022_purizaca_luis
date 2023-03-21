PROCESSOR 18F57Q84
#include "config.inc"
#include "Library.inc"
#include <xc.inc>

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
 
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    CALL Delay_ms,1
    CALL Delay_ms,1 
    CALL Delay_ms,1
    
Config_OSC:		    ;Configuración del oscilador Interno a una frecuencia de 8MHz
    BANKSEL OSCCON1
    MOVLW   0x60	    ;seleccionamos el bloque del  osc interno con un div:1
    MOVWF   OSCCON1,1
    MOVLW   0x02	    ;seleccionamos una freciencia de 4MHz(0x02)
    MOVWF   OSCFRQ,1	
    RETURN
    
Config_Port:		    ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3
    ;Config LED
    BANKSEL PORTF
    CLRF    PORTF,1	    ;PORT = 0
    BSF	    LATF,3,1	    ;LAT <3> = 1 (Led OFF)
    CLRF    ANSELF,1	    ;ANSELF <7> = 0 (Port F digital)
    BCF	    TRISF,3,1	    ;TRISF <3> = 0 (RF3 como salida)
 
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1	    ;PORTA <7:0> = 0
    CLRF    ANSELA,1	    ;ANSELA <7:0> = 0 (Port A digital)
    BSF	    TRISA,3,1	    ;TRIS <3> = 1 (RA3 como salida)
    BSF	    WPUA,3,1	    ;Activamos la resitencia Pull-Up del pin RA3
   
    RETURN

   
END resetVect