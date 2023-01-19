;-------------------------------------------------------------------------------
; @file  : P1-Corrimiento_Leds.X
; @brief : Corrimiento de bits pares e impares
; @brief : Product Version: MPLAB X IDE v6.00
; @date  : 14/01/2023
; @author: PURIZACA DEDIOS LUIS ANTONIO
;-------------------------------------------------------------------------------    
PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include <xc.inc>

    
PSECT udata_acs
;reserva 1 byte en acces ram 
contador1: DS 1	
contador2: DS 1

PSECT resetVect,class=CODE,reloc=2
    
resetVect:
    goto Main
    
PSECT CODE
 
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    BSF	    STATUS,5
    MOVLW   00000000B
    MOVWF   TRISC
    MOVWF   TRISE
    BCF	    STATUS,5
/******************************************************************************/
Off:
    CLRF    LATC
    CLRF    LATE
    BSF	    LATF,3,1
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Off
    CALL    Button,1
    GOTO    ON
ON:
    
    MOVLW 00000001B
    MOVWF PORTC
    MOVLW  00000010B
    MOVWF  PORTE,1
    CALL    Esperar_250,1
    
    MOVLW 00000010B
    MOVWF PORTC
    MOVLW  00000001B
    MOVWF PORTE
    CALL    Esperar_250,1
    
    MOVLW 00000100B
    MOVWF PORTC
    MOVLW  00000010B
    MOVWF PORTE,1
    CALL    Esperar_250,1
    
    MOVLW 00001000B
    MOVWF PORTC
    MOVLW  00000001B
    MOVWF PORTE
    CALL    Esperar_250,1
    
    MOVLW 00010000B
    MOVWF PORTC
    MOVLW  00000010B
    MOVWF PORTE,1
    CALL    Esperar_250,1
    
    MOVLW 00100000B
    MOVWF PORTC
    MOVLW  00000001B
    MOVWF PORTE
    CALL    Esperar_250,1
    
    MOVLW 01000000B
    MOVWF PORTC
    MOVLW  00000010B
    MOVWF PORTE,1
    CALL    Esperar_250,1
    
    MOVLW 10000000B
    MOVWF PORTC
    MOVLW  00000001B
    MOVWF PORTE
    CALL    Esperar_250,1
    
    GOTO    ON
    
B_press:
    BSF	    LATF,3,1	    ; Led on
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    RETURN
    CALL    Button,1
    

Fin:
    BCF	    LATF,3,1
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Fin
    CALL    Button,1
    GOTO    Off
    
    
    
/******************************************************************************/
Config_OSC:		;Configuraci�n del oscilador Interno a una frecuencia de 8MHz
    BANKSEL OSCCON1
    MOVLW   0x64	;seleccionamos el bloque del  osc interno con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02	;seleccionamos una freciencoa de 8MHz
    MOVWF   OSCFRQ	
    RETURN
    
Config_Port:	  ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3

    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1
    CLRF    ANSELA,1
    BSF	    TRISA,3,1
    BSF	    WPUA,3,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3

/******************************************************************************/    
Button:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	20		; + 1 Tcy 
    MOVWF	contador1,0	; + 1 Tcy 
    CALL	Delay_ms,1	; + 2 Tcy 
RETURN	
    
Esperar_250:			; + 2 Tcy 
    MOVLW	29		; + 1 Tcy
    MOVWF	contador1,0	; + 1 Tcy
    CALL	Delays,1	; + 2 Tcy
RETURN 
/******************************************************************************/
Delay_ms:			; + 2 Tcy 
    MOVWF   contador2,0		; + 1 Tcy 
Out_loop:			;
    MOVLW   249			; A Tcy 
    MOVWF   contador1,0		; A Tcy	
In_loop:
    NOP				; [ A B ] Tcy 
    DECFSZ  contador1,1,0	; [(3+(B-1)) A] Tcy	
    GOTO    In_loop		; [ 2 A ( B - 1 ) ] Tcy	
    DECFSZ  contador2,1,0	; [ 3 + ( A - 1 )] Tcy	
    GOTO    Out_loop		; [ 2 ( A - 1 ) ] Tcy	
    NOP				; 1 Tcy	
    RETURN		        ;  2 Tcy

Delays:				; + 2 Tcy 
    MOVWF   contador2,0		; + 1 Tcy | coloca el valor de "A" a la variable "contador1". A traves de Acces Bank
Outloop:			;
    MOVLW   219			; A Tcy 
    MOVWF   contador1,0		; A Tcy	
Inloop:
    CALL    B_press,1		; [ 6 A B ] Tcy 
    DECFSZ  contador1,1,0	; [(3+(B-1)) A] Tcy	
    GOTO    Inloop		; [ 2 A ( B - 1 ) ] Tcy	
    DECFSZ  contador2,1,0	; [ 3 + ( A - 1 )] Tcy	
    GOTO    Outloop		; [ 2 ( A - 1 ) ] Tcy	
    NOP				; 1 Tcy	
    RETURN		        ;  2 
RETURN
END resetVect    