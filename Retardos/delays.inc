;-------------------------------------------------------------------------------
; @file  : delays.inc
; @brief : Librería para delays (retardos) desde 10us hasta 250ms||Frequency = 4MHz||1Tcy=1us
; @brief : Product Version: MPLAB X IDE v6.00
; @date  : 20/11/2022
; @author: PURIZACA DEDIOS LUIS ANTONIO
;-------------------------------------------------------------------------------
    
PSECT udata_acs
;reserva 1 byte en acces ram 
contador1: DS 1	
contador2: DS 1
PSECT code    
/******************************************************************************  
 Lista de retardos implementados " CALL X,1 ":
     
    CALL Delay_10us,1
    CALL Delay_25us,1
    CALL Delay_50us,1 
    CALL Delay_100us,1 
    CALL Delay_200us,1	   
    CALL Delay_250us,1
    CALL Delay_500us,1
    CALL Delay_1ms,1    
    CALL Delay_5ms,1
    CALL Delay_10ms,1    
    CALL Delay_25ms,1
    CALL Delay_50ms,1
    CALL Delay_100ms,1
    CALL Delay_200ms,1
    CALL Delay_250ms,1
******************************************************************************/   
;_______________________________________________________________________________
;______________________RETARDOS ES us___________________________________________
;_______________________________________________________________________________ 
Delay_10us:			; 2 Tcy 
    CALL Delay_6u,1		; 6 Tcy 
RETURN				; 2 Tcy
;_______________________________________________________________________________
Delay_25us:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	4		; + 1 Tcy | Se carga el valor de 4
    MOVWF	contador1,0	; + 1 Tcy | coloca "4" a la variable "contador1". A traves de Acces Bank
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    GOTO	Delay_us	; + 2 Tcy | Se dirige a la función "Delay_us", para ejecutarla con el valor de 4
;_______________________________________________________________________________  
Delay_50us:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	10	        ; + 1 Tcy | Se carga el valor de 10
    MOVWF	contador1,0	; + 1 Tcy | coloca "10" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_us,1	; + 2 Tcy | llama y ejecuta "Delay_us" con el valor de 10. Se conservan los registros
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________
Delay_100us:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	23		; + 1 Tcy | Se carga el valor de 23
    MOVWF	contador1,0	; + 1 Tcy | coloca "23" a la variable "contador1". A traves de Acces Bank
    GOTO	Delay_us	; + 2 Tcy | Se dirige a la función "Delay_us", para ejecutarla con el valor de 23
;_______________________________________________________________________________     
Delay_200us:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	48		; + 1 Tcy | Se carga el valor de 48
    MOVWF	contador1,0	; + 1 Tcy | coloca "48" a la variable "contador1". A traves de Acces Bank
    GOTO	Delay_us	; + 2 Tcy | Se dirige a la función "Delay_us", para ejecutarla con el valor de 48
;_______________________________________________________________________________   
Delay_250us:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	60		; + 1 Tcy | Se carga el valor de 60
    MOVWF	contador1,0	; + 1 Tcy | coloca "60" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_us,1	; + 2 Tcy | llama y ejecuta "Delay_us" con el valor de 60. Se conservan los registros
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________   
Delay_500us:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	123	        ; + 1 Tcy | Se carga el valor de 123
    MOVWF	contador1,0	; + 1 Tcy | coloca "123" a la variable "contador1". A traves de Acces Bank
    GOTO	Delay_us	; + 2 Tcy | Se dirige a "Delay_us", para ejecutarla con el valor de 123
;_______________________________________________________________________________
;____________________RETARDOS EN ms_____________________________________________
;_______________________________________________________________________________
; A = variable del bucle exterior = 1
; B = variable del bucle interior = 247
; T = [6+(B+((B-1)+3)+(2(B-1))+3+1+2)] = [ 4 B + 12 ] Tcy
Delay_1ms:		        ; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW   1			; + 1 Tcy | Se carga el valor de 1
    MOVWF   contador2,0		; + 1 Tcy
Ext_loop1ms:			; 
    MOVLW   247			; + 1 Tcy | Se carga el valor de 247
    MOVWF   contador1,0		; + 1 Tcy | coloca "247" a la variable "contador1". A traves de Acces Bank
Int_loop1ms:			; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    DECFSZ  contador1,1,0	; + [(B-1)+3] Tcy |Decrementa y salta cuando es igual a 0| Almacenamos el resultado en f. 
    GOTO    Int_loop1ms		; + [ 2 ( B - 1 ) ] Tcy | Se dirige a la funcion "Int_loop1ms"
    DECFSZ  contador2,1,0	; + 3 Tcy | Decrementa y salta cuando es igual a 0 | Almacenamos el resultado en f. 
    GOTO    Ext_loop1ms		; + [ (k2-1) * 2 ] Tcy  | Se dirige a la funcion "Ext_loop1ms"
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    RETURN			; + 2 Tcy para retornar
;_______________________________________________________________________________   
Delay_5ms:			; + 2 Tcy (al hacer el llamado "CALL")
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    MOVLW	5		; + 1 Tcy | Se carga el valor de 5
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    MOVWF	contador1,0	; + 1 Tcy | coloca "5" a la variable "contador1". A traves de Acces Bank
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    CALL	Delay_ms,1	; + 2 Tcy | llamar y ejecutar "Delay_ms" con el valor de 5  . Se conservan los registros
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________   
Delay_10ms:			; + 2 Tcy (al hacer el llamado "CALL")
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy)
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    MOVLW	10		; + 1 Tcy | Se carga el valor de 10
    MOVWF	contador1,0	; + 1 Tcy | coloca "5" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 10. Se conservan los registros
    CALL	Delay_10us,1	; + 2 Tcy | llama y ejecuta "Delay_10us". Se conservan los registros
    CALL	Delay_6u,1	; + 2 Tcy | llama y ejecuta "Delay_6us". Se conservan los registros
RETURN			        ; + 2 Tcy para retornar
;_______________________________________________________________________________   
Delay_25ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	25		; + 1 Tcy | Se carga el valor de 25
    MOVWF	contador1,0	; + 1 Tcy | coloca "25" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,0	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 25. No se conservan los registros
    CALL	Delay_50us,1	; + 2 Tcy | llama y ejecuta "Delay_50us". Se conservan los registros
    CALL	Delay_10us,1	; + 2 Tcy | llama y ejecuta "Delay_10us". Se conservan los registros
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________   
Delay_50ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	50		; + 1 Tcy | Se carga el valor de 50
    MOVWF	contador1,0	; + 1 Tcy | coloca "50" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 50. Se conservan los registros
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    CALL	Delay_10us,1	; + 2 Tcy | llama y ejecuta "Delay_10us". Se conservan los registros
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    CALL	Delay_100us,1	; + 2 Tcy | llama y ejecuta "Delay_100us". Se conservan los registros
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    CALL	Delay_25us,1	; + 2 Tcy | llama y ejecuta "Delay_25us". Se conservan los registros
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________   
Delay_100ms:			; + 2 Tcy (al hacer el llamado "CALL")
    NOP				; + 1 Tcy (No ejecuta nada, pero aniade 1 Tcy) 
    MOVLW	100		; + 1 Tcy | Se carga el valor de 100
    MOVWF	contador1,0	; + 1 Tcy | coloca "100" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 100. Se conservan los registros
    CALL	Delay_200us,1	; + 2 Tcy | llama y ejecuta "Delay_200us". Se conservan los registros
    CALL	Delay_50us,1	; + 2 Tcy | llama y ejecuta "Delay_50us". Se conservan los registros
    CALL	Delay_25us,1	; + 2 Tcy | llama y ejecuta "Delay_25us". Se conservan los registros
    CALL	Delay_6u,1	; + 2 Tcy | llama y ejecuta "Delay_6u". Se conservan los registros
    CALL	Delay_6u,1	; + 2 Tcy | llama y ejecuta "Delay_6u". Se conservan los registros
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________  
Delay_200ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	200		; + 1 Tcy | Se carga el valor de 200
    MOVWF	contador1,0	; + 1 Tcy | coloca "200" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 200. Se conservan los registros
    CALL	Delay_538u,1	; + 2 Tcy | llama y ejecuta "Delay_538us". Se conservan los registros
    CALL	Delay_50us,1	; + 2 Tcy | llama y ejecuta "Delay_50us". Se conservan los registros
RETURN				; + 2 Tcy para retornar
;_______________________________________________________________________________  
Delay_250ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVLW	250		; + 1 Tcy | Se carga el valor de 250
    MOVWF	contador1,0	; + 1 Tcy | coloca "250" a la variable "contador1". A traves de Acces Bank
    CALL	Delay_ms,1	; + 2 Tcy | llama y ejecuta "Delay_ms" con el valor de 250. Se conservan los registros
    CALL	Delay_538u,1	; + 2 Tcy | llama y ejecuta "Delay_538us". Se conservan los registros
    CALL	Delay_200us,1	; + 2 Tcy | llama y ejecuta "Delay_200us". Se conservan los registros
RETURN				; + 2 Tcy para retornar
/******************************************************************************/    

/* La formula se deduce a traves de: T = [(((k-1)+3+(2k-2)+k)+2]Tcy = [4 k + 2]Tcy
   Si asumimos que se llama la funcion, contando los retardos que generan las 
   instrucciones, tenemos que: T=[4 k + 2 + 8]Tcy
   T = [ 4 k + 10 ] Tcy      */
Delay_us:			; 
    NOP				; k Tcy | (No ejecuta nada, pero aniade 1 Tcy por cada vuelta del bucle) 
    DECFSZ	contador1,1,0	; [(k-1)+3] Tcy | Decrementa y salta cuando es igual a 0|Almacena el resultado en f.  
    GOTO	Delay_us	; [ 2 k - 2 ] Tcy  | Se dirige a la funcion "Delay_us"
RETURN				;  2 Tcy para retornar
;_______________________________________________________________________________
/* Se deduce que: T = [1+A+A+AB+(3+(B-1)A)+2A(B-1)+(3+(A-1))+2(A-1)+1+2] Tcy
   T = [ 4 + 5 A + 4 A B ] , Donde "A" corresponde al valor asignado al bucle
   exterior y "B" al valor asignado al bucle interior.
   Si asumimos que se llama la funcion, contando los retardos que generan las 
   instrucciones, tenemos que: T = [ 4 + 5 A + 4 A B + 8 ]
   T = [ 12 + 5 A + 4 A B ]		 */
    
Delay_ms:			; + 2 Tcy (al hacer el llamado "CALL")
    MOVWF   contador2,0		; + 1 Tcy | coloca el valor de "A" a la variable "contador1". A traves de Acces Bank
Out_loop:			;
    MOVLW   248			; A Tcy | se carga el valor de 248
    MOVWF   contador1,0		; A Tcy	| el valor de "B" (fijado como 248) pasa a "contador1". A traves de Acces Bank
In_loop:
    NOP				; [ A B ] Tcy |(No ejecuta nada, pero aniade 1 Tcy por cada vuelta del bucle) 
    DECFSZ  contador1,1,0	; [(3+(B-1)) A] Tcy	| Decrementa y salta cuando es igual a 0 |Almacena el resultado en f.
    GOTO    In_loop		; [ 2 A ( B - 1 ) ] Tcy	| Se dirige a la funcion "In_loop"
    DECFSZ  contador2,1,0	; [ 3 + ( A - 1 )] Tcy	| Decrementa y salta cuando es igual a 0 |Almacena el resultado en f.
    GOTO    Out_loop		; [ 2 ( A - 1 ) ] Tcy	| Se dirige a la funcion "Out_loop"
    NOP				; 1 Tcy	| ( No ejecuta nada, pero aniade 1 Tcy )
    RETURN		        ;  2 Tcy para retornar
;_______________________________________________________________________________
;Funciones usadas para completar los ciclos y así ganar precision:
    
Delay_538u:			; 2 Tcy (al hacer el llamado "CALL")
    MOVLW	132		; 1 Tcy | se carga el valor de 132
    MOVWF	contador1,0	; 1 Tcy	|Se carga el valor de "132" en "contador1" . A traves de Acces Bank
    CALL	Delay_us,1	; 2 Tcy | llama y ejecuta "Delay_us" con el valor de 132. Se conservan los registros
RETURN				;  2 Tcy para retornar
;_______________________________________________________________________________ 
Delay_6u:			; 2 Tcy (al hacer el llamado "CALL")
    NOP				; 1 Tcy	( No ejecuta nada, pero aniade 1 Tcy )
    NOP				; 1 Tcy ( No ejecuta nada, pero aniade 1 Tcy )
RETURN				; 2 Tcy para retornar