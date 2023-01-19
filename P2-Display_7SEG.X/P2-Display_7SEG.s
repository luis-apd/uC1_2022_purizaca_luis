;-------------------------------------------------------------------------------
; @file  : P2-Display_7SEG.s
; @brief : DISPLAY 7 SEGMENTOS, 0-9 Y A-F
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
    MOVWF   TRISD
    BCF	    STATUS,5
    CLRF    LATD
/******************************************************************************/
Numeros:	    ; Seleccionamos los  pines a encender, por cada numero
    MOVLW   00000001B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   01001111B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   00010010B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   00000110B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   01001100B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   00100100B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   01100000B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   00001111B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   00000000B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    MOVLW   00001100B
    MOVWF   PORTD
    CALL    Esperar_1s,1
    
    GOTO    Numeros
Letras:		    ; Seleccionamos los  pines a encender, por cada letra
    MOVLW   00001000B
    MOVWF   PORTD
    CALL    Button,1
    CALL    Btn,1
    MOVLW   01100000B
    MOVWF   PORTD
    CALL    Button,1
    CALL    Btn,1
    MOVLW   00110001B
    MOVWF   PORTD
    CALL    Button,1
    CALL    Btn,1
    MOVLW   01000010B
    MOVWF   PORTD
    CALL    Button,1
    CALL    Btn,1
    MOVLW   00110000B
    MOVWF   PORTD
    CALL    Button,1
    CALL    Btn,1
    MOVLW   00111000B
    MOVWF   PORTD
    CALL    Button,1
    CALL    Btn,1
    GOTO    Letras
    B_press:
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    RETURN
    GOTO    Letras
    Btn:
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Numeros
    RETURN
/******************************************************************************/
Config_OSC:		; Oscilador Interno a 8MHz
    BANKSEL OSCCON1
    MOVLW   0x64	; Osc interno con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02	;seleccionamos una freciencia de 4MHz
    MOVWF   OSCFRQ	
    RETURN
Config_Port:	  ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3
    ;Config button
    BANKSEL PORTA
    CLRF    PORTA,1
    CLRF    ANSELA,1
    BSF	    TRISA,3,1
    BSF	    WPUA,3,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3
/****************************************************************************/    
Button:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	99		; + 1 Tcy 
    MOVWF	contador1,0	; + 1 Tcy 
    CALL	Delay_ms,1	; + 2 Tcy 
RETURN	
Esperar_1s:			;  T = [6+5X+9XY] 
    MOVLW	50		; + 1 Tcy 
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
    RETURN		        ; 2 
Delays:				; + 2 Tcy 
    MOVWF   contador2,0		; + 1 Tcy 
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
    RETURN		        ; 2 Tcy
RETURN
END resetVect    


