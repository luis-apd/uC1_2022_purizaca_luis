PROCESSOR 18F57Q84
#include "bt_config.inc"    /*config statements should precede project file includes.*/
#include <xc.inc>
    
PSECT udata_acs
offset:	  DS 1	    ;reserva 1 byte en acces ram 
Reset_t:  DS 1  
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto main
    
;Pasos para implementar computed goto
;1. Escribir el byte superior en PCLATU
;2. Escribir el byte alto en PCLATH
;3. Escribir el byte bajo en PCL
;NOTA: el offset debe ser multiplicado por 2 para el alineamiento en memoria
PSECT CODE
main:
    CALL Config_OSC,1
    CALL Config_Port,1
	
    CALL    Reload,1
Loop_T:
    BTG	    LATF,3,0
    MOVLW   low highword(table)
    MOVWF   PCLATU,1
    MOVLW   high(table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
    CALL    table
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Loop_T
    DECF    offset,1,0
    DECFSZ  Reset_t,1,0 
    GOTO    Loop_T
    GOTO    Reload
    
    
    
    Reload:
	MOVLW   0x0A		    ;definimos el valor del offset
	MOVWF   offset,0
	MOVLW	0x0A
	MOVWF	Reset_t,0
    GOTO    Loop_T
table:
    ADDWF   PCL,1,0
    RETLW   00000000B	;offset: 0
    RETLW   00000000B	;offset: 1
    RETLW   0x01	;offset: 2
    RETLW   0x02	;offset: 3  
    RETLW   0x04	;offset: 4
    RETLW   0x08	;offset: 5
    RETLW   0x10	;offset: 6
    RETLW   0x20	;offset: 7
    RETLW   0x40	;offset: 8
    RETLW   0x80	;offset: 9
    RETLW   0x100	;offset: 10
    
    

 
    
Config_OSC:		;Configuración del oscilador Interno a una frecuencia de 8MHz
    BANKSEL OSCCON1
    MOVLW   0x60	;seleccionamos el bloque del  osc interno con un div:1
    MOVWF   OSCCON1
    MOVLW   0x03	;seleccionamos una freciencoa de 8MHz
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