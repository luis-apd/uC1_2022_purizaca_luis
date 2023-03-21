PSECT udata_acs
;reserva 1 byte en acces ram 
contador1: DS 1	
contador2: DS 1
PSECT code    
// t = (8+(2+(k-1)+3+(2k-2))) =  4 k + 10
/*test:				    ; 2 -- CALL
    MOVLW	230		    ; 1
    MOVWF	contador1,0	    ; 1			    ; 2 
    GOTO	Delay_us;,1   	    ;		2	-- CALL
    RETURN			    ;	    2    
/*
Delay_us:			    ;  
    NOP				    ; k Tcy
    DECFSZ	contador1,1,0	    ; ( k - 1 ) + 3
    GOTO	Delay_us	    ; 2 k - 2
RETURN				    ; 2
   */
 
 
 
;T= Delay_ms +11 
 
test:				    ;2
    MOVLW	20		    ;1
    MOVWF	contador1,0	    ;1
    CALL	Delay_ms,1	    ; 2
RETURN				    ;2
    

Delay_ms:		    ;
    MOVWF   contador2,0	    ; 1 Tcy
Out_loop:		    ; 2 Tcy -- Call
    MOVLW   248	    	    ; 1 Tcy -> (B)
    MOVWF   contador1,0	    ; 1 Tcy
In_loop:
    NOP						; B
    DECFSZ  contador1,1,0		        ; (B-1) + 3 Tcy
    GOTO    In_loop				;(2(B-1))
    DECFSZ  contador2,1,0			;
    GOTO    Out_loop	    ;(A-1) * 2 Tcy
    NOP			    ; 1
    RETURN					 ; 2
    
    
    
    
    
    
    
    
    
/*    
test:			    ; 2call
    MOVLW   2		    ; 1 Tcy -> (A)
    MOVWF   contador2,0	    ; 1 Tcy
;T= 6 + 4k
Ext_loop4:		    ; /    2 Tcy -- Call
    MOVLW   2		    ; 1 Tcy -> (B)
    MOVWF   contador1,0	    ; 1 Tcy.
							;6
Int_loop4:		    ; 0	    /
    NOP			    ;				B
    DECFSZ  contador1,1,0   ;				(B-1) + 3 
    GOTO    Int_loop4	    ;				(2(B-1))
    DECFSZ  contador2,1,0   ;				3
    GOTO    Ext_loop4	    ;0  (A-1) * 2 Tcy		0
    NOP			    ;				1
    RETURN		    ;2
    */