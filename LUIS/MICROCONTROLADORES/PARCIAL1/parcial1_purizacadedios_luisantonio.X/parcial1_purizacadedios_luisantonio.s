PROCESSOR 18F57Q84
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
goto Main

PSECT CODE
Main:
    
    ;definir variables( X=2	   Y=4 )
    X EQU 2		
    Y EQU 4		
    
    MOVLW X		;W->X (Cargamos W con wl valor de X)
    MOVWF 0x500,a	;(W)->5: 0x500
    
    MOVLW Y		;W->Y (Cargamos W con wl valor de Y)
    MOVWF 0x501,a	;(W)->5: 0x501
    CPFSGT 0x500,a	;si x>y salta una casilla sino continua
    GOTO    Menor
 Mayor:			;A=5X+3Y 
    MOVLW 5		;5 ->w
    MULLW X		;X*5->PROD(0X4F0)
    MOVF 0x4F3,w,a	;prod->w
    MOVWF 0x500,a	;x->f(0x500)
    
    MOVLW 3		;3->w
    MULLW Y		;Y*3->PROD(0X4F0)
    MOVF 0x4F3,w,a	;prod->w
    MOVWF 0x501,a	;Y->f(0x501)
    
    MOVF 0x500,w,a	;0x500->w
    ADDWF 0x501,a	;X+Y->501
    goto Exit
 Menor:			;A=7X-9Y
    MOVLW 7		;7->w
    MULLW X		;X*7->PROD(0X4F0)
    MOVF 0x4F3,w,a	;prod->w
    MOVWF 0x500,a	;x->f(0x500)
    
    MOVLW 9		;9->w
    MULLW Y		;Y*9->PROD(0X4F0)
    MOVF 0x4F3,w,a	;prod->w
    MOVWF 0x501,a	;Y->f(0x501)
   
    SUBWF 0x501,a	;X+Y->501
    NOP
 Exit:
    NOP
END resetVect    