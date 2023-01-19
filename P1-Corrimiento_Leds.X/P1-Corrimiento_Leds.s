;-------------------------------------------------------------------------------
; @file  : P1-Corrimiento_Leds.X
; @brief : Corrimiento de bits pares e impares
; @brief : Product Version: MPLAB X IDE v6.00
; @date  : 18/01/2023
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
    CLRF    LATC	    ;Limpeza de puertos
    CLRF    LATE
    BSF	    LATF,3,1	    
    
/******************************************************************************/
corrimiento:
    Imp:
    MOVLW   00000001B		    ; Se carga el valor en W
    MOVWF   LATC		    ; Se escribe el valor de W en el puerto C
    MOVWF   LATE,1		    ; Se escribe el valor de W en el puerto E|Indica que el desplazamiento es impar
    CALL    Esperar_250,1	    ; Esperar 250ms

    RLNCF   LATC,1,0		    ; Desplaza a la izquierda el bit escrito del puerto C
    ; Esperar 250ms:
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
    MOVLW   00000010B		    ; Se carga el valor en W
    MOVWF   LATE,1		    ; Se escribe el valor de W en el puerto E|Indica que el desplazamiento es par
    
    RLNCF   LATC,1,0		    ; Desplaza a la izquierda el contenido del puerto C
    ; Esperar ( 250 + 250 )ms = 500 ms (Aprox.)
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
B_press:		    ; Se realiza el llamado en delay "Esperar_250" 
    BSF	    LATF,3,1	    ; Led off (led_apoyo, para visualizar cuando este pausado el desplazamiento)
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    RETURN		    ; Si no se presione, retornará al loop "Esperar_250"; En cso se pulse, salta, abandonando el loop
    CALL    Delay_25ms,1    ; Para evitar el rebote mecanico
Pause:			    ; Se pausa el desplazamiento y se mantiene encendido el led en el que se encontraba
    BTFSC   PORTA,3,0	    ; PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Pause	    ; Mientras no se pulse, se mantendra el loop; cuando se pulsa, se salta y sale del loop
    CALL    Delay_25ms,1    ; Para evitar el rebote mecanico
    MOVLW   00000001B	    ; Se carga el valor en el W 
    CPFSEQ  LATE	    ; Se compara W con el puerto E para conocer si antes de pausar estaba en desplazamiento par o impar
    GOTO    RegresarP	    ; Cuando son diferentes, continua, se dirige al caso cuando es par 
    GOTO    RegresarimP	    ; Cuando son iguales, salta una linea, se dirige al caso cuando es impar  
RegresarP:		    ; Actuará como el caso de desplazamiento par hasta que se complete el byte
    RLNCF   LATC,1,0	    ; Desplaza a la izquierda el bit del puerto C (A partir de donde se quedo)
    ; Esperar ( 250 + 250 )ms = 500 ms (Aprox.)
    CALL    Esperar_250,1
    CALL    Esperar_250,1

    MOVLW   10000000B	    ; Se carga el valor en el W 
    CPFSEQ  LATC	    ; Se compara W con el puerto C para conocer si llegó al final del byte
    GOTO    RegresarP	    ; Si son diferentes, se genera un loop, que desplazara hasta que sean iguales
    GOTO    Imp		    ; Si son iguales, se dirige al desplazamiento principal - caso impar    
RegresarimP:		    ; Actuará como el caso de desplazamiento impar hasta que se complete el byte
    RLNCF   LATC,1,0	    ; Desplaza a la izquierda el bit del puerto C (A partir de donde se quedo)
    CALL    Esperar_250,1   ; Esperar 250 ms
    
    MOVLW   10000000B	    ; Se carga el valor en el W 
    CPFSEQ  LATC	    ; Se compara W con el puerto C para conocer si llegó al final del byte
    GOTO    RegresarimP	    ; Si son diferentes, se genera un loop, que desplazara hasta que sean iguales
    GOTO    Par		    ; Si son iguales, se dirige al desplazamiento principal - caso par    
    
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