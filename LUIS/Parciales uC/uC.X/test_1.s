PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include <xc.inc>

PSECT udata_acs
 contador1: DS 1
 contador2: DS 1
 contador3: DS 1
 Acumulador1: DS 1
 Acumulador2: DS 1

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
    
PSECT CODE 
    
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    MOVLW 0x00
    MOVWF TRISB
    ;MOVLW 10011001B
    ;MOVWF 0X508
    
   
    
    

CUENTA:
MOVLW	10
MOVWF	Acumulador2,0
MOVF	PORTB		; Cargar el registro en el registro w
ANDLW	0x00		; realiza operacion And con 0x0F
MOVWF	PORTB		; guarda en portb
MOVWF   0x504
DECENA:   

MOVF	PORTB		; Cargar el registro en el registro w
ANDLW	0xF0		; realiza operacion And con 0x0F
MOVWF	PORTB		; guarda en portb
MOVWF   0x504
 
MOVLW	10
MOVWF	Acumulador1,0
UNIDAD:
CALL	SUMA    
DECFSZ  Acumulador1,1,0
GOTO	UNIDAD

MOVF	PORTB		; Cargar el registro en el registro w
ANDLW	11110000B		; realiza operacion And con 0x0F
MOVWF	PORTB		; guarda en portb
MOVWF   0x504
    
CALL	SUMA_D
DECFSZ  Acumulador2,1,0
GOTO	DECENA
GOTO	CUENTA
    
    
SUMA:   
    CALL Delay_500ms
    MOVLW 0001B
    ADDWF 0x504,0,0
    BANKSEL PORTB
    MOVWF PORTB,1
    movwf 0x504
RETURN
    
    
SUMA_D:
    
    MOVLW 00010000B
    ADDWF 0x504,0,0
    BANKSEL PORTB
    MOVWF PORTB,1
    movwf 0x504
    CALL Delay_500ms
RETURN


    
RESTA:
    MOVLW 0001B
    MOVWF 0x505
    SUBWF 0x504,0,0
    MOVWF PORTB
    MOVWF 0x504
    CALL Delay_500ms
RETURN
    
 Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1 
    MOVLW   0x60        ;Seleccionamos el bloque del osc con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02        ; Seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ 
    RETURN
   
 Config_Port:  ;PORT-LAT-ANSEL-TRIS	    LED:RF3	BUTTON:RA3
    ;Config Led
    BANKSEL PORTB
    CLRF    PORTB,1	; PORTF = 0 
    BSF     LATB,7,1
    CLRF    ANSELB,1	; ANSELF<7:0> = 0 -PORT F DIGITAL
    BCF     TRISB,7,1

    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1	; PORTA<7:0> = 0
    CLRF    ANSELA,1	; PortA digital
    BSF	    TRISA,3,1	; RA3 como entrada
    BSF	    WPUA,3,1	; Activamos la resistencia Pull-Up del pin RA3
    RETURN 
    
Delay_500ms:                       ;2Tcy -- Call
    MOVLW   50                  ;(100 )1Tcy -- k2
    MOVWF   contador3,0            ;1Tcy
; T = (6 + 4k)us         1Tcy = 1us
Ciclo3:
    MOVLW   10
    MOVWF   contador2,0
Out_Loop:                         ;2Tcy -- Call
    MOVLW   250                    ;1Tcy -- k1
    MOVWF   contador1,0            ;1Tcy
In_Loop:
    NOP                            ;kTcy
    DECFSZ  contador1,1,0          ;(k1-1) + 3Tcy
    GOTO    In_Loop              ;(k1-1)*2Tcy
    DECFSZ  contador2,1,0          ;
    GOTO    Out_Loop              ;
    DECFSZ  contador3,1,0
    GOTO    Ciclo3
    RETURN                         ;2Tcy
    
    
NUMERO:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	10		; + 1 Tcy | Se carga el valor de 250
    MOVWF	contador1,0	; + 1 Tcy | coloca "250" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 250. Se conservan los registros
RETURN	
    
Delay_ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVWF   contador2,0		; + 1 Tcy | coloca el valor de "A" a la variable "contador1". A traves de Acces Bank
Out_loop:			;
    MOVLW   10			; A Tcy | se carga el valor de 248
    MOVWF   contador1,0		; A Tcy	| el valor de "B" (fijado como 248) pasa a "contador1". A traves de Acces Bank
In_loop:
    CALL SUMA				; [ A B ] Tcy |(No ejecuta nada, pero aniade 1 Tcy por cada vuelta del bucle) 
    DECFSZ  contador1,1,0	; [(3+(B-1)) A] Tcy	| Decrementa y salta cuando es igual a 0 |Almacena el resultado en f.
    GOTO    In_loop		; [ 2 A ( B - 1 ) ] Tcy	| Se dirige a la funcion "In_loop"
    DECFSZ  contador2,1,0	; [ 3 + ( A - 1 )] Tcy	| Decrementa y salta cuando es igual a 0 |Almacena el resultado en f.
    GOTO    Out_loop		; [ 2 ( A - 1 ) ] Tcy	| Se dirige a la funcion "Out_loop"
    NOP				; 1 Tcy	| ( No ejecuta nada, pero aniade 1 Tcy )
    RETURN	
END resetVect