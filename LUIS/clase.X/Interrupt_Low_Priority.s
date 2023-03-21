PROCESSOR 18F57Q84
#include "bt_config.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
;#include "delays.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main

PSECT ISRVect,class=CODE,reloc=2
    ISRVect
    BTFSS   PIR1,0,0	; Se ha producido la interrupcion int0?
    GOTO Exit
    
Toggle_Led: 
    BCF	PIR1,0,0	; Limpiamos el flag de int0
    BCF	LATF,3,0	; Toggle led
    
Exit:
    RETFIE
    
PSECT udata_acs
contador1: DS 1	
contador2: DS 1
offset:	DS 1
counter: DS 1

PSECT CODE
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    CALL Config_PPS,1
    CALL Config_INT0,1
    GOTO Reload
    
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
    MOVLW   0x05
    MOVWF   counter,0		; carga del contador con el numero de offsets
    MOVLw   0x00
    MOVWF   offset,0		; definimos el valor del offset inicial
    GOTO    Loop 
/***************************************************************************************************/ 
    Config_OSC:		; Oscilador Interno a 8MHz
    BANKSEL OSCCON1	; Seleccionar banco
    MOVLW   0x60	; Osc interno con un div:1
    MOVWF   OSCCON1	;Cargar valor
    MOVLW   0x02	; seleccionamos una freciencoa de 4MHz
    MOVWF   OSCFRQ	; cargar valor
    RETURN

    Config_Port:		    ;POR-LAT-ANSEL-TRIS LED:RF3, BUTTON:RA3
    ;Config LED
    BANKSEL PORTF
    CLRF    PORTF,1	    ;PORT = 0
    BSF	    LATF,3,1	    ;LAT <3> = 1 (Led OFF)
    CLRF    ANSELF,1	    ;ANSELF <7> = 0 (Port F digital)
    BCF	    TRISF,3,1	    ;TRISF <3> = 0 (RF3 como salida)
 
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1	    ;PORTA <7:0> = 0
    CLRF    ANSELA,1	    ;ANSELA <7:0> = 0 (Port A digital)
    BSF	    TRISA,3,1	    ;TRIS <3> = 1 (RA3 como salida)
    BSF	    WPUA,3,1	    ;Activamos la resitencia Pull-Up del pin RA3
   
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
    MOVWF   INT0PPS,1	    ; INT0 -> RA3
    RETURN
    
;Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0:
    BCF	INTCON0,5,0	; INTCON0<IPEN> = 0 -- Deshabilitar prioridades
    BCF INTCON0,0,0	; INTCON0<INT0EDG> = 0 -- INT0 por flanco bajada
    BCF	PIR1,0,0	; PIR1<INT0IF> = 0 -- Limpiamos el flag de interrupcion
    BSF	PIE1,0,0	; PIE1<INT0IE> = 1 -- HABILITAMOS el flag de interrupcion
    BSF	INTCON0,7,0	; INTCON0<GIE/GIEH> = 1 -- Habilitamos las interrupciones
    RETURN
    
Table:
    ADDWF   PCL,1,0
    RETLW   11111111B	; OFFSET 0
    RETLW   11111110B	; OFFSET 1
    RETLW   11111101B	; OFFSET 2
    RETLW   11111011B	; OFFSET 3
    RETLW   11110111B	; OFFSET 4
    
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
    RETURN		    ; 2Tcy
        
End resetVect    