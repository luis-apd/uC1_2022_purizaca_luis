PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include "delays.inc" 
#include <xc.inc>

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
/******************************************************************************/    
PSECT ISRVectLowPriority,class=CODE,reloc=2
ISRVectLowPriority:
    BTFSS   PIR6,0,0	; �Se ha producido la INT1?
    GOTO    Exit0
Toggle_Led:
    BCF	    PIR6,0,0	; limpiamos el flag de INT1
    CALL    Subrutina,1
    ;CALL    Subrutina,1
    ;CALL    Subrutina,1
    ;CALL    Subrutina,1
Exit0:
    RETFIE

;-------------------------------------------------------------------------------
PSECT ISRVectHighPriority,class=CODE,reloc=2
ISRVectHighPriority:
    BTFSS   PIR1,0,0	; �Se ha producido la INT0?
    GOTO    Exit1
Leds_Off:
    BCF	    PIR1,0,0	; limpiamos el flag de INT0
    
    ;DECF    Divisor,1
    BTG	    LATF,3,0	; toggle Led
    
Exit1:
    RETFIE
    
/******************************************************************************/     
PSECT udata_acs
Divisor:  DS 1	    
;contador2:  DS 1
    
PSECT CODE
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    CALL Config_PPS,1
    CALL Config_INT0_INT1,1
    
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
    ;Config User_button
    BANKSEL PORTA	; seleccionar banco
    CLRF    PORTA,1	; seleccion puerto
    CLRF    ANSELA,1	; definir como analogico
    BSF	    TRISA,3,1	; configurar el pin 3 del puerto A como entrada
    BSF	    WPUA,3,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3

    ;Config Ext_Button
    BANKSEL PORTB	; seleccionar banco
    CLRF    PORTB,1	; seleccion puerto
    CLRF    ANSELB,1	; definir como analogico
    BSF	    TRISB,1,1	; configurar el pin 3 del puerto A como entrada
    BSF	    WPUB,1,1	; RESISTENCIA PULL-UP ACTIVADA DEL PIN RA3

    ;Config LED
    BANKSEL PORTF
    CLRF    PORTF,1	    ;PORT = 0
    BSF	    LATF,3,1	    ;LAT <3> = 1 (Led OFF)
    CLRF    ANSELF,1	    ;ANSELF <7> = 0 (Port F digital)
    BCF	    TRISF,3,1	    ;TRISF <3> = 0 (RF3 como salida)
    
    BANKSEL PORTC
    CLRF    PORTC,1	
    BCF     LATC,0,1	
    CLRF    ANSELC,1	
    BCF     TRISC,0,1     ;PORTC.0 : SALIDA
    
    BANKSEL PORTB
    CLRF    PORTB,1	
    BCF     LATB,0,1	
    CLRF    ANSELB,1	
    BCF     TRISB,0,1     ;PORTC.0 : SALIDA
    RETURN
/******************************************************************************/   
Config_PPS:
    ;Config INT0
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	    ; INT0 -> RA3
    
    ;Config INT1
    BANKSEL INT1PPS
    MOVLW   0x09
    MOVWF   INT1PPS,1	    ; INT1 -> RB1
    RETURN
    
;Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0_INT1:
    ;Configuracion de prioridades
    BSF	INTCON0,5,0	; INTCON0<IPEN> = 1 -- Habilitar prioridades
    BANKSEL IPR1
    BSF	IPR1,0,1	; IPR1<INT0IP> = 1 -- INT0 de alta prioridd
    BCF IPR6,0,1	; IPR6<INT1IO> = 0 -- INT1 de baja prioridad
    
    ; Config INT0
    BCF	INTCON0,0,0	; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR1,0,0	; PIR1<INT01F> = 0 -- limpiar flag de interrupcion
    BSF	PIE1,0,0	; PIE1<INT0IE> = 1 -- habilita interrupcion Ext0
    
    ; Config INT1
    BCF	INTCON0,1,0	; INTCON0<INT0EDG> = 0 -- INT0 por flanco de bajada
    BCF	PIR6,0,0	; PIR6<INT01F> = 0 -- limpiar flag de interrupcion
    BSF	PIE6,0,0	; PIE6<INT0IE> = 1 -- habilita interrupcion Ext1
    
    ;Habilitacion de interrupciones
    BSF INTCON0,7,0	; INTCON0<GIE/GIEH> = 1 -- Habilita interrupcionres de forma global
    BSF INTCON0,6,0     ; INTCON0<GIEL> = 1 -- Habilita prioridades de baja prioridad
    RETURN    
    
/******************************************************************************/    
/******************************************************************************/        

Subrutina:
    BTG	    LATF,3,0	; Toggle led
    CALL    Delay_250ms,1
    BTG	    LATF,3,0	; Toggle led
    CALL    Delay_250ms,1
    BTG	    LATF,3,0	; Toggle led
    CALL    Delay_250ms,1
    ;BTG	    LATF,3,0	; Toggle led
RETURN   
;_______________________________________________________________________________
/******************************************************************************/        
END resetVect 