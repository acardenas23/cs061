;=================================================
; Name: Ana Cardenas Beltran
; Email: 
; 
; Lab: lab 3, ex 4
; Lab section: 
; TA: 
; 
;=================================================
.orig x3000
;--------------
;Instructions
;--------------
	LD R1, DATA_PTR		;loads the location of x4000
	LD R2, NEWLINE		;loads newline into r2
	LEA R0, MSG			;
	PUTS				;gets message onto screen			
DO_WHILE_LOOP			; starts while loop
	GETC				;
	OUT 				;displays characters on the screen
	STR R0, R1, #0		;stores r1 in r0 (currently the location)	
	ADD R1, R1, #1		;adds 1 to r1 to increase location
	NOT R0, R0			;flips r0
	ADD R0, R0, #1		;add 1 for 2's complement
	ADD R0, R0, R2		;add R0 and R2(which has newline)
Brnp DO_WHILE_LOOP		;if R0 + R0!=0, character was not newline
END_DO_WHILE_LOOP	

	LD R1, DATA_PTR		;loads location again
	
DO_WHILE_LOOP1			;starts second while loop
	LDR R0, R1, #0		;loads value of R1 into R0
	OUT					;Prints r0 to the screen as an ascii character
	ADD R1, R1, #1		;Increments the location
	NOT R0, R0			;flips R0
	ADD R0, R0, #1		;adds 1 to r0 to get the 2's complement
	ADD R0, R0, R2		;adds r0 and r2 to know if they are equal
Brnp DO_WHILE_LOOP1		;if equal to zero, stop loop
END_DO_WHILE_LOOP1

	HALT
;-----------
;Data
;------------
	DATA_PTR	.FILL	x4000
	MSG		.STRINGZ	"Enter characters \n" 
	NEWLINE	.STRINGZ		"\n"
	
.END	
