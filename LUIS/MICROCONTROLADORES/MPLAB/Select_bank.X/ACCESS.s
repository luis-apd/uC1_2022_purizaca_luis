

PROCESSOR 18F57Q84
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main:
    ;BSR:0x04E0, WREG: 0x04E8 MEM PAG.86
    MOVLW   5		    ;5->W (cargamos W con el valor de 5)
    MOVWF   0x500,0	    ;(W)->f : 0x600
    
    
    MOVLW   6		    ;6->W (cargamos W con el valor de 6)
    MOVWF   0x505,0	    ;(W)->f : 0x505
    
    
    MOVLW   255		    ;255->W (cargamos W con el valor de 255)
    MOVWF   0x550,0	    ;(W)->f : 0x550
    
    MOVLB   9		    ;seleccionamos el banco 9
    MOVLW   10		    ;10->W (cargamos W con el valor de 10)
    MOVWF   0x55F,0	    ;(W)->f : 0x55F
    
END resetVect