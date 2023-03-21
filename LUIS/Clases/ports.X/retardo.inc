PSECT udata_acs
 contador1: DS 1	;reserva 1 byte en acces ram
 contador2: DS 1	;reserva 1 byte en acces ram

PSECT code
Delay_250ms:
    MOVLW   251		    ; 1 Tcy -> (k2)
    MOVWF   contador2,0	    ; 1 Tcy
;T= 6 + 4k
Ext_loop:		    ; 2 Tcy -- Call
    MOVLW   248    ; 1 Tcy -> (k1)
    MOVWF   contador1,0	    ; 1 Tcy
Int_loop:
    NOP			    ; (k1 * Tcy)
    DECFSZ  contador1,1,0   ; (k1-1) + 3 Tcy
    GOTO    Int_loop
    DECFSZ  contador2,1,0
    GOTO    Ext_loop	    ; (k2-1) * 2 Tcy
    RETURN