 PROCESSOR 18F57Q84
#include "bt_config.inc" 
;#include "delays.inc" 
#include <xc.inc>

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT ISRVect,class=CODE,reloc=2
ISRVect:
    BTFSS   PIR1,0,0	; Se ha producido la interrupcion int0?
    GOTO    Exit
Toggle_Led: 
    BCF	    PIR1,0,0	; Limpiamos el flag de int0
    ;*Aquí se inserta el codigo a ejecutar*
    CALL    Subrutina
Exit:
    RETFIE
 
PSECT udata_acs
contador1:  DS 1	    
contador2:  DS 1
    
PSECT CODE
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    CALL Config_PPS,1
    CALL Config_INT0,1
    BSF	    STATUS,5
    MOVLW   00000000B
    MOVWF   TRISC
    BCF	    STATUS,5
    CLRF    LATC	    ;Limpeza de puertos
    BSF	    LATF,3,1	    
    
/******************************************************************************/
Inicio_Loop:
    MOVLW   00000001B		    ; Se carga el valor en W
    MOVWF   LATC		    ; Se escribe el valor de W en el puerto C
    CALL    Delay_250ms,1	    ; Esperar 250ms
    corrimiento:
    ;BTG    LATF,3,1	    ; Complemento Led
    RLNCF   LATC,1,0	
    CALL    Delay_250ms,1
    GOTO    corrimiento

/******************************************************************************/
Config_OSC:		; Oscilador Interno a 8MHz
    BANKSEL OSCCON1	; Seleccionar banco
    MOVLW   0x60	; Osc interno con un div:1
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

    ;Config LED
    BANKSEL PORTF
    CLRF    PORTF,1	    ;PORT = 0
    BSF	    LATF,3,1	    ;LAT <3> = 1 (Led OFF)
    CLRF    ANSELF,1	    ;ANSELF <7> = 0 (Port F digital)
    BCF	    TRISF,3,1	    ;TRISF <3> = 0 (RF3 como salida)
    RETURN
/******************************************************************************/   
Config_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	    ; INT0 -> RA3
    RETURN
    
;Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0:
    ;Configuracion de prioridades
    BCF	INTCON0,5,0	; INTCON0<IPEN> = 0 -- Desabilitar prioridades
    BCF	INTCON0,0,0	; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0	; PIR1<INT01F> = 0 -- limpiar flag de interrupcion
    BSF	PIE1,0,0	; PIE1<INT0IE> = 1 -- habilita interrupciones externas
    BSF INTCON0,7,0	; INTCON0<GIE/GIEH> = 1 -- Habilita interrupcionres de forma global
    RETURN    
    
/******************************************************************************/    

Subrutina:
    BTG	    LATF,3,0	; Toggle led
    CALL    Delay_250ms,1
    BTG	    LATF,3,0	; Toggle led
    
RETURN
    
/******************************************************************************/        
Delay_250ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	250		; + 1 Tcy | Se carga el valor de 250
    MOVWF	contador1,0	; + 1 Tcy | coloca "250" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 250. Se conservan los registros
    RETURN
;_______________________________________________________________________________
/*    T = [ 12 + 5 A + 4 A B ]		 */
    
Delay_ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVWF   contador2,0		; + 1 Tcy | coloca el valor de "A" a la variable "contador1". A traves de Acces Bank
Out_loop:			;
    MOVLW   249			; A Tcy | se carga el valor de 248
    MOVWF   contador1,0		; A Tcy	| el valor de "B" (fijado como 248) pasa a "contador1". A traves de Acces Bank
In_loop:
    NOP				; [ A B ] Tcy |(No ejecuta nada, pero aniade 1 Tcy por cada vuelta del bucle) 
    DECFSZ  contador1,1,0	; [(3+(B-1)) A] Tcy	| Decrementa y salta cuando es igual a 0 |Almacena el resultado en f.
    GOTO    In_loop		; [ 2 A ( B - 1 ) ] Tcy	| Se dirige a la funcion "In_loop"
    DECFSZ  contador2,1,0	; [ 3 + ( A - 1 )] Tcy	| Decrementa y salta cuando es igual a 0 |Almacena el resultado en f.
    GOTO    Out_loop		; [ 2 ( A - 1 ) ] Tcy	| Se dirige a la funcion "Out_loop"
    NOP				; 1 Tcy	| ( No ejecuta nada, pero aniade 1 Tcy )
    RETURN		        ;  2 Tcy para retornar
;_______________________________________________________________________________
/******************************************************************************/        
END resetVect 