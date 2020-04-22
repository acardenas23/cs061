;=================================================
; Name: Ana Cardenas Beltran
; Email:  acard079@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 
; TA: David Feng
; 
;=================================================
.orig x3000
;Instructions
	LD R0, HEX_x61 ;put hex_x61 in r0
	LD R1, HEX_x1A ;load hex_x1A in r1
	
	DO_WHILE_LOOP ;start while loop
		OUT
		ADD R0, R0, #1
		ADD R1, R1, #-1
		BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP ;end while loop

HALT
;Local data
	HEX_x61 .FILL x61 ;store x61 on hex_x61
	HEX_x1A .FILL x1A ; store x1A in Hex_x1A
.end
