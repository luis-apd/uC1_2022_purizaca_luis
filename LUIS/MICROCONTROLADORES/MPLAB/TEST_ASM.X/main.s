
PROCESSOR 18F57Q84
; PIC18F57Q84 Configuration Bit Settings
; Assembly source line config statements
#include <xc.inc>


PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main:
    ;config oscillator for 8MHz

    BANKSEL OSCCON1
    movlw   0x60h
    movwf   OSCCON1,1	; Source:HFINTOSC & DIV=1
    movlw   0x03h
    movwf   OSCFRQ,1	; Clock = 8MHz
    
    ;config Port F for Led On
    BANKSEL PORTF
    BCF	    PORTF,3,1
    BANKSEL LATF
    BSF	    LATF,3,1	;led off
    BANKSEL ANSELF
    CLRF    ANSELF,1	;port f:digital
    BANKSEL TRISF
    BCF	    TRISF,3,1	;RF3:output
    
Led_on:
    BANKSEL LATF
    BCF	    LATF,3,1
    goto Led_on
END resetVect


