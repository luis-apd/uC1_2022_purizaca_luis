;-------------------------------------------------------------------------------
; @file  : LuispD_archivo.s
; @brief : El programa se encarga de operar una u otra expresion dependiendo si
;	   se cumple la condicion de X>Y ;5X+3Y, en caso se cumpla y 7X-9Y, en
;	   caso no cumpla. 
; @date  : 20/11/2022
; @author: PURIZACA DEDIOS LUIS ANTONIO
;-------------------------------------------------------------------------------
    
PROCESSOR 18F57Q84
#include <xc.inc>
   
PSECT resetVect,class=CODE,reloc=2
resetVect:
;Se inicializan las valiables, X=2 e Y=4
    X EQU 2		
    Y EQU 4		
    
PSECT CODE
Main:
;Se carga el valor de X a W, para ubicarlo en la direccion 0x501
   MOVLW X
   MOVWF 0x501,a

;Se carga el valor de Y a W, para ubicarlo en la direccion 0x502
   MOVLW Y		
   MOVWF 0x502,a
   
; Se compara si X>Y; si cumple, el programa salta una linea, accediendo a la 
; etiqueta "CUMPLE"; si no cumple, continua, Dirigiendose a la etiqueta "NOCUMPLE"
   CPFSGT 0x501,a
   GOTO    NOCUMPLE

;Etiqueta "CUMPLE" ( A=5X+3Y )
 CUMPLE:
;Se carga el valor de X en W
   MOVLW X
;Se multiplica W con 5 y se almacena en (0X4F3), luego se mueve
;a W, para alamcenarlo en la direccion 0x500
   MULLW 5
   MOVF 0x4F3,w,a
   MOVWF 0x500,a
   
;Se carga el valor de Y en W
   MOVLW Y	
;Se multiplica W con 3 y se almacena en (0X4F3), luego se mueve a W, para
;alamcenarlo en la direccion 0x501
   MULLW 3		
   MOVF 0x4F3,w,a	
   MOVWF 0x501,a

;Se realiza la suma y se guarda en la direccion 0x500
;Por lo tanto, La variable A (A=5X+3Y), queda guardada en la direccion 0x500
   ADDWF 0x500,a	
   
;Al haber completado las instrucciones, se direcciona a la etiqueta "EXIT"
   goto EXIT

;Etiqueta "NOCUMPLE" ( A=7X-9Y )
NOCUMPLE:
;Se carga el valor de X en W
    MOVLW X
;Se multiplica W con 7 y se almacena en (0X4F3), luego se mueve
;a W, para posteriormente, alamcenarlo en la direccion 0x500
    MULLW 7
    MOVF 0x4F3,w,a
    MOVWF 0x500,a

;Se carga el valor de Y en W
    MOVLW Y
;Se multiplica W con 9 y se almacena en (0X4F3), luego se mueve
;a W, para posteriormente, alamcenarlo en la direccion 0x501
    MULLW 9
    MOVF 0x4F3,w,a
    MOVWF 0x501,a
;Se realiza la suma (Resta) y se guarda en la direccion 0x500
;Por lo tanto, La variable A (A=7X-9Y), queda guardada en la direccion 0x500
    SUBWF 0x500,a
    NOP
EXIT:
    NOP 
END resetVect


