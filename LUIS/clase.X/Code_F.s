PROCESSOR   18F57Q84
#include    "bt_config.inc"  /config statements should precede project file includes./
#include    <xc.inc>
#include    "delays.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    GOTO  Main
    
PSECT ISRVect,class=CODE,reloc=2
    BTFSS   PIR1,00,0             ; ¿Se ha producido la INT0?
    GOTO    Exit
Toggle_Led:
    BCF     PIR1,0,0              ; limpiamos el flag de INT0
    B     LATF,3,0              ; toggle Led
Exit:
    RETFIE
    
PSECT udata_acs
offset:  DS 1
counter: DS 1
    
PSECT CODE
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_PPS,1
    CALL    Config_INT0,1
    GOTO    Reload
    
Loop:
    BANKSEL PCLATU
    MOVLW   low highword(Table)
    MOVWF   PCLATU,1
    MOVLW   high(Table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
    CALL    Table
    MOVWF   LATC,0
    CALL    Delay_250ms,1
    DECFSZ  counter,1,0
    GOTO    Next_Seq
    GOTO    Reload
    
Next_Seq:
    INCF    offset,1,0
    GOTO    Loop
    
Reload:
    MOVLW   0x10
    MOVWF   counter,0           ; carga del contador con el numero de offset
    MOVLW   0x00
    MOVWF   offset,0            ; definimos el valor de offset inicial
    GOTO    Loop
    
Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1 
    MOVLW   0x60                ;Seleccionamos el bloque del osc interno(HFINTOSC) con DIV=1
    MOVWF   OSCCON1,1
    MOVLW   0x02                ; Seleccionamos una frecuencia de Clock de 4MHz
    MOVWF   OSCFRQ,1
    RETURN
   
Config_Port:
    ;Config Led
    BANKSEL PORTF
    CLRF    PORTF,1
    BSF     LATF,3,1
    CLRF    ANSELF,1
    BCF     TRISF,3,1
    
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1
    CLRF    ANSELA,1
    BSF     TRISA,3,1
    BSF     WPUA,3,1
    
    ;Config PORTC
    BANKSEL PORTC
    SETF    PORTC,1
    SETF    LATC,1
    CLRF    ANSELC,1
    CLRF    TRISC,1
    
    RETURN
    
Config_PPS:
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1
    RETURN
    
; Secuencia para configurar interrupción:
;    1. Definir prioridades
;    2. Configurar interrupción
;    3. Limpiar el flag
;    4. Habilitar la interrupción
;    5. Habilitar las interrupciones globales
Config_INT0:
    BCF     INTCON0,5,0         ; INTCON0<IPEN> = 0 -- Deshabiliatr prioridades
    BCF     INTCON0,0,0         ; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF     PIR1,0,0            ; PIR1<INT0IF> = 0 -- limpiamos el flag de interrupción
    BSF     PIE1,0,0            ; PIR1<INT0IE> = 0 -- habilitamos la interrupción ext
    BSF     INTCON0,7,0         ; INTCON0<GIE/GIEH> = 1 -- habilitamos la interrupción de
    RETURN
    
 Table:
    ADDWF   PCL,1,0
    RETLW   01111110B           ; offset: 0
    RETLW   10111101B           ; offset: 1
    RETLW   11011011B           ; offset: 2
    RETLW   11100111B           ; offset: 3
    RETLW   11111111B           ; offset: 4
    RETLW   11100111B           ; offset: 5
    RETLW   11011011B           ; offset: 6
    RETLW   10111101B           ; offset: 7
    RETLW   01111110B           ; offset: 8
    RETLW   11111111B           ; offset: 4
End resetVect