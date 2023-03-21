PROCESSOR 18F57Q84
#include "bt_config.inc"    /*config statements should precede project file includes.*/
#include <xc.inc>
    
PSECT udata_acs
offset:  DS 1	    ;reserva 1 byte en acces ram 
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
    
    BSF	    STATUS,5
    MOVLW   00000000B
    MOVWF   TRISC
    
    MOVLW   00001001B		    ;definimos el valor del offset
    MOVWF   offset,0
    MOVLW   low highword(table)
    MOVWF   PCLATU,1
    MOVLW   high(table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
;   MOVLW   0x02
;   MULWF   offset,0
;   MOVF    PRODL,w
    LOOP:
    CALL table
    
    nop
    GOTO LOOP
table:
    ADDWF   PCL,1,0
    RETLW   00000000B	;offset: 0
    RETLW   00000001B	;offset: 1
    RETLW   00000010B	;offset: 2  
    RETLW   00000011B	;offset: 3
    RETLW   00000100B	;offset: 4
    RETLW   00000101B	;offset: 5
    RETLW   00000110B	;offset: 6
    RETLW   00000111B	;offset: 7
    RETLW   00001000B	;offset: 8
    RETLW   00001001B	;offset: 9
    
END resetVect