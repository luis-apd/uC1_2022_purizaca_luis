PSECT udata_acs
contador1: DS 1	;reserva 1 byte en acces ram
tiempo:	   DS 1 
/******************************************************************************/ 
 PSECT code
 
Delay_100us: 
    MOVLW	2
    MOVWF	tiempo
    GOTO	Delay_10us
RETURN
    
Delay_10us: 
    MOVLW	tiempo
    MOVWF	contador1,0
Delay_Loop10u:
    NOP
    DECFSZ	contador1,1,0
    GOTO	Delay_Loop10u
RETURN   

 