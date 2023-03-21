
PROCESSOR 18F57Q84
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main:
    
    MOVLW 7		;7->w
    MULLW 2		;X*7->PROD(0X4F0)
    MOVF 0x4F3,w,a	;prod->w
    MOVWF 0x500,a	;x->f(0x500)
    
    MOVLW 9		;9->w
    MULLW 4		;Y*9->PROD(0X4F0)
    MOVF 0x4F3,w,a	;prod->w
    MOVWF 0x501,a	;Y->f(0x501)
   
    SUBWF 0x501,a	;X+Y->501
    NOP
    
END resetVect



