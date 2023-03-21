PROCESSOR 18F57Q84
#include "Bit_Config.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
;#include "Retardos.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT ISRTimer1,class=CODE,reloc=2
ISRTimer1:
    BTFSS   PIR3,4,0	; ¿Se ha producido la interrupcion del TMR1?
    GOTO    Exit
Toggle_Led:
    BCF	    PIR3,4,0	; limpiamos el flag del TMR1
    
    ; Recarga del valor inicial
    BANKSEL TMR1H
    MOVLW   0x0B
    MOVWF   TMR1H
    MOVLW   0xDC
    MOVWF   TMR1L
   
    BTG	    LATF,3,0	; toggle Led
Exit:
    RETFIE

PSECT udata_acs
contador1:  DS 1	    
contador2:  DS 1
    
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
    
    ;Config PORTC
    BANKSEL PORTC
    CLRF    PORTC,1	
    CLRF    LATC,1	
    CLRF    ANSELC,1	
    BCF	    TRISC,0,1	;PORTC.0 : SALIDA
    RETURN
    
Config_Timer:
    ; Config. TMR1
    BANKSEL T1CLK
    MOVLW   0x01
    MOVWF   T1CLK   ; Fuente de reloj : Fosc/4
    BANKSEL T1CON
    MOVLW   0x31
    MOVWF   T1CON   ; Config. Preescaler 8 y TMR1: On
    
    ; Carga del valor inicial Ts = 500ms
    BANKSEL TMR1H
    MOVLW   0x0B
    MOVWF   TMR1H
    MOVLW   0xDC
    MOVWF   TMR1L
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

Delay_250ms:		    ; 2Tcy -- Call
    MOVLW   250		    ; 1Tcy -- k2
    MOVWF   contador2,0	    ; 1Tcy
; T = (6 + 4k)us	    1Tcy = 1us
Ext_Loop:		    
    MOVLW   249		    ; 1Tcy -- k1
    MOVWF   contador1,0	    ; 1Tcy
Int_Loop:
    NOP			    ; k1*Tcy
    DECFSZ  contador1,1,0   ; (k1-1)+ 3Tcy
    GOTO    Int_Loop	    ; (k1-1)*2Tcy
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop
    RETURN		


