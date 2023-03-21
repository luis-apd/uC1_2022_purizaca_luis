
PROCESSOR 18F57Q84
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main:
    ;BSR:0x04E0, WREG: 0x04E8
    MOVLB   6		    ;seleccionamos el banco 6
    MOVLW   5		    ;5->W (cargamos W con el valor de 5)
    MOVWF   0x600,1	    ;(W)->f : 0x600
    
    MOVLB   7		    ;seleccionamos el banco 7
    MOVLW   6		    ;6->W (cargamos W con el valor de 6)
    MOVWF   0x700,1	    ;(W)->f : 0x700
    
    MOVLB   8		    ;seleccionamos el banco 8
    MOVLW   255		    ;255->W (cargamos W con el valor de 255)
    MOVWF   0x802,1	    ;(W)->f : 0x802
    
    MOVLB   9		    ;seleccionamos el banco 9
    MOVLW   10		    ;10->W (cargamos W con el valor de 10)
    MOVWF   0x910,1	    ;(W)->f : 0x910
    
END resetVect


