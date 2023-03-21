;-------------------------------------------------------------------------------
; @file  : P1-Corrimiento_Leds.s
; @brief : Corrimiento de bits pares e impares
; @brief : Product Version: MPLAB X IDE v6.00
; @date  : 14/01/2023
; @author: PURIZACA DEDIOS LUIS ANTONIO
;-------------------------------------------------------------------------------
    
PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include "delays.inc" 
#include <xc.inc>
PSECT udata_acs
;reserva 1 byte en acces ram 
count1: DS 1	
count2: DS 1
Desplazo:  DS 1
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
    MOVLW   1
    MOVWF   Desplazo
    CLRF    LATC	    ;Limpeza de puertos
    CLRF    LATE
    BSF	    LATF,3,1	    
    
/******************************************************************************/
corrimiento:
    Imp:
    MOVLW   00000001B
    MOVWF   LATC
    MOVWF   LATE,1
    CALL    Esperar_250,1

    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    ;_____________________
    Par:
    MOVLW   00000010B
    MOVWF   LATE,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
   
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1
    GOTO    corrimiento
B_press:
    BSF	    LATF,3,1	    ; Led off (led_apoyo, para visualizar cuando este pausado el desplazamiento)
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    RETURN
    CALL    Delay_25ms,1
Pause:
    ;BCF	    LATF,3,1	    ; Led on (led_apoyo, para visualizar cuando este pausado el desplazamiento)
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Pause
    CALL    Delay_25ms,1
    ;GOTO    corrimiento  
    MOVLW   00000001B
    CPFSEQ  LATE
    GOTO    RegresarP
    GOTO    RegresarimP
RegresarP:
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    CALL    Esperar_250,1

    
    MOVLW   10000000B
    CPFSEQ  LATC
    GOTO    RegresarP
    GOTO    Imp
    
RegresarimP: 
    RLNCF   LATC,1,0
    CALL    Esperar_250,1
    
    MOVLW   10000000B
    CPFSEQ  LATC
    GOTO    RegresarimP
    GOTO    Par
    
/******************************************************************************/
Config_OSC:		; Oscilador Interno a 8MHz
    BANKSEL OSCCON1	; Seleccionar banco
    MOVLW   0x64	; Osc interno con un div:1
    MOVWF   OSCCON1	;Cargar valor
    MOVLW   0x02	; seleccionamos una freciencoa de 4MHz
    MOVWF   OSCFRQ	; cargar valor
    RETURN
    
Config_Port:	  ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3
    ;Config button
    BANKSEL PORTA	; seleccionar banco
    CLRF    PORTA,1	; seleccion puerto
    CLRF    ANSELA,1	; definir como analogico
    BSF	    TRISA,3,1	; configurar el pin 3 del puerto A como entrada
    BSF	    WPUA,3,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3
/******************************************************************************/    
Esperar_250:	    		; T = [6+5X+9XY]
    MOVLW	8		;13 ; + 1 Tcy
    MOVWF	count1,0	; + 1 Tcy
    CALL	Delays,1	; + 2 Tcy
RETURN				;+ 2 Tcy 
/******************************************************************************/    
Delays:				; + 2 Tcy 
    MOVWF   count2,0		; + 1 Tcy | coloca el valor de "A" a la variable "contador1". A traves de Acces Bank
Outloop:			;
    MOVLW   219			; A Tcy 
    MOVWF   count1,0		; A Tcy	
Inloop:
    CALL    B_press,1		; [ 6 A B ] Tcy 
    DECFSZ  count1,1,0	; [(3+(B-1)) A] Tcy	
    GOTO    Inloop		; [ 2 A ( B - 1 ) ] Tcy	
    DECFSZ  count2,1,0	; [ 3 + ( A - 1 )] Tcy	
    GOTO    Outloop		; [ 2 ( A - 1 ) ] Tcy	
    NOP				; 1 Tcy	
    RETURN		        ;  2 
RETURN
END resetVect   
    
    