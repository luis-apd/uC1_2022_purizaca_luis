PROCESSOR 18F57Q84
#include "bt_config.inc" 
;#include "delays.inc" 
#include <xc.inc>
 
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT ISRTimer1,class=CODE,reloc=2
ISRTimer1:
    BTFSS   PIR3,4,0	; ¿Se ha producido la interrupción del TMR1?
    GOTO    Exit
Toggle_Led:
    BCF	    PIR3,4,0	; limpiamos el flag de TMR1
    
    ;Carga del valor inicial
    CALL    V_inicial,1
    
    
    BTG      LATB,0,0	; F = 1/2 
    BTG      LATF,3,0	; 1
    
Exit:
    RETFIE


    
PSECT CODE    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_Timer,1
    CALL    Config_ISR,1
  
Loop:
    GOTO    Loop
    
Config_OSC:
    ;Configuracion del Oscilador Interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60    ;seleccionamos el bloque del osc interno(HFINTOSC) con DIV=1
    MOVWF   OSCCON1,1 
    MOVLW   0x02    ;seleccionamos una frecuencia de Clock = 4MHz
    MOVWF   OSCFRQ,1
RETURN
    
Config_Port:	
    ;Config Led
    BANKSEL PORTF
    CLRF    PORTF,1	
    BSF	    LATF,3,1	
    CLRF    ANSELF,1	
    BCF	    TRISF,3,1		 
    
    ;Config Led
    BANKSEL PORTB
    CLRF    PORTB,1	
    BCF	    LATB,0,1	
    CLRF    ANSELB,1	
    BCF	    TRISB,0,1
    
    ;Config PORTC
    BANKSEL PORTC
    CLRF    PORTC,1	
    CLRF    LATC,1	
    CLRF    ANSELC,1	
    BCF    TRISC,0,1     ;PORTC.0 : SALIDA
RETURN

; Config. TMR1    
Config_Timer:
    ; Fuente de reloj: Fosc/4
    BANKSEL T1CLK
    MOVLW   0x01
    MOVWF   T1CLK,1  
    ;Config. Prescaler 8 y TMR1: On
    BANKSEL T1CON
    MOVLW   0x31
    MOVWF   T1CON,1  
    
    V_inicial:
    ;Carga del valor inicial 63036  (2 Bytes = 65535 + 1 (overflow)=65536 )
    BANKSEL TMR1H
    MOVLW   0x00
    MOVWF   TMR1H,1
    MOVLW   0x00
    MOVWF   TMR1L,1 
RETURN
    
  
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_ISR:
    BCF	INTCON0,5,0 ; INTCON0<IPEN> = 0 -- Deshabilitar prioridades
    BCF	PIR3,4,0    ; PIR3<TMR1IF> = 0 -- limpiamos el flag de interrupcion
    BSF	PIE3,4,0    ; PIE3<TMR1IE> = 1 -- habilitamos la interrupcion por desbordamiento del TMR1
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 -- habilitamos las interrupciones de forma global
    RETURN

End resetVect