PROCESSOR 18F57Q84
#include "bt_config.inc" 
#include <xc.inc>

PSECT udata_acs
 contador1: DS 1
 contador2: DS 1
 contador3: DS 1


PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
    
PSECT CODE 
    
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    MOVLW 00000000B
    MOVWF TRISB
    MOVLW 10011001B
    MOVWF 0X508
    
Loop:
    CALL    Delay_500ms
    BTFSC   PORTA,3,0  ;PORTA<3> = 0? - Button press?
    GOTO N0
    GOTO N99
;0-9
N0:
    MOVLW 0000B
    MOVWF PORTB
    movwf 0x504
    CALL Delay_500ms
    GOTO button
N99:
    MOVLW 0x99
    MOVWF PORTB
    movwf 0x504
    CALL Delay_500ms
    GOTO button
button:
    BTFSC PORTA,3,0  ;|<3> = 0? - Button press?
    goto ANALISIS_SUMA
    goto ANALISIS_RESTA
SUMA:
    MOVLW 0001B
    ADDWF 0x504,0,0
    BANKSEL PORTB
    MOVWF PORTB,1
    movwf 0x504
    CALL Delay_500ms
    GOTO button
SUMA2:

    MOVLW 0x07
    ADDWF 0x504,0,0
    MOVWF PORTB
    MOVWF 0x504
    CALL Delay_500ms
    GOTO button    
ANALISIS_SUMA:
    CPFSEQ 0x508
    goto p3
    goto button
p3:    
    BTFSC 0X504,3
    btfss 0X504,0
    goto SUMA
    goto SUMA2
RESTA:

    MOVLW 0001B
    MOVWF 0x505
    SUBWF 0x504,0,0
    MOVWF PORTB
    MOVWF 0x504
    CALL Delay_500ms
    GOTO button
RESTA2:
 
    MOVLW 0x07
    MOVWF 0x505
    SUBWF 0x504,0,0
    MOVWF PORTB
       MOVWF 0x504
    CALL Delay_500ms
    GOTO button    
ANALISIS_RESTA:
    MOVWF 0X510
    TSTFSZ 0X510
    GOTO p2
    goto button
p2:    
    BTFSS 0X504,3
    BTFSC 0X504,0
    goto RESTA
    goto ANALISIS_RESTA2
ANALISIS_RESTA2:
    BTFSS 0X504,2
    BTFSC 0X504,1
    goto RESTA
    goto RESTA2
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
    MOVLW   100                   ;1Tcy -- k2
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
    
END resetVect