;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
		ADD R1, R1, #0
		LD R6, MENU_3200							;CALLING MENU SUBROUTINE
		JSRR R6
		LD R0, newline
		OUT
		LEA R0, goodbye
		PUTS

HALT
;---------------	
;Data
;---------------
;Subroutine pointers
MENU_3200		.FILL x3200


;Other data 
newline 		.fill '\n'
ASCII_48_MAIN	.FILL #-48


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3200
;HINT back up 

		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R6, BACKUP_R6_3200
		ST R7, BACKUP_R7_3200
		;PRINT OUT MENU
	MENU_SUB
		LD R3, Menu_string_addr
PRINT_MENU_LOOP
		LDR R0, R3, #0		;GET VAL OF R3 IN R0
		OUT
		ADD R3, R3, #1		;NEXT SPOT
		LDR R0, R3, #0
		ADD R0, R0, #0
		BRnp PRINT_MENU_LOOP		;WHEN ARRAY REACHES ZERO, STOP
END_PRINT_MENU_LOOP
		;ALLOW USER TO ENTER A NUMBER FROM 1-7
		GETC
		OUT
		LD R4, ASCII_49_3200
		ADD R4, R4, R0
		BRn ERROR_3200					;IF NUM IS SMALLER THAN 49, INVAL INPUT
		BRnz CHECK_NEXT_3200
		
	CHECK_NEXT_3200
		LD R4, ASCII_55_3200
		ADD R4, R4, R0
		BRp ERROR_3200					;IF NUM BIGGER THAN 55, INVAL INPUT
		BRnz STORE_R1
	ERROR_3200
		LD R0, NEWLINE_3200
		OUT
		LEA R0, Error_msg_1
		PUTS
		LD R3, Menu_string_addr
		BRnzp PRINT_MENU_LOOP
		
		
	STORE_R1
		ADD R1, R0, #0					;COPY INPUT TO R1
		LD R4, ASCII_48_3200
		ADD R1, R1, R4					;SUBTRACT 48 TO GET DEC VALUE
		BRnzp REDIRECT
REDIRECT
		LD R4, ASCII_7_3200
		ADD R3, R1, R4					;IF INPUT WAS 7
		BRz THE_END_3400
		BRnp CHECK_6
	CHECK_6
		ADD R4, R4, #1
		ADD R3, R1, R4
		BRz GO_FIRST_FREE
		BRnp CHECK_5
	GO_FIRST_FREE
		LD R6, FIRST_FREE_4400
		JSRR R6
		BRnzp MENU_SUB
	CHECK_5
		ADD R4, R4, #1
		ADD R3, R1, R4
		BRz GO_MACHINE_STATUS
		BRnp CHECK_4
	GO_MACHINE_STATUS
		LD R6, MACHINE_STATUS_4200
		JSRR R6
		BRnzp MENU_SUB
	CHECK_4
		ADD R4, R4, #1
		ADD R3, R1, R4
		BRz GO_NUM_FREE_MACHINES
		BRnp CHECK_3
	GO_NUM_FREE_MACHINES
		LD R6, NUM_FREE_MACHINES_4000
		JSRR R6
		BRnzp MENU_SUB
	CHECK_3
		ADD R4, R4, #1
		ADD R3, R1, R4
		BRz GO_NUM_BUSY_MACHINES
		BRnp CHECK_2
	GO_NUM_BUSY_MACHINES
		LD R6, NUM_BUSY_MACHINES_3800
		JSRR R6
		BRnzp MENU_SUB
	CHECK_2
		ADD R4, R4, #1
		ADD R3, R1, R4
		BRz GO_ALL_MACHINES_FREE
		BRnp GO_ALL_MACHINES_BUSY
	GO_ALL_MACHINES_FREE
		LD R6, ALL_MACHINES_FREE_3600
		JSRR R6
		BRnzp MENU_SUB
	GO_ALL_MACHINES_BUSY
		LD R6, ALL_MACHINES_BUSY_3400
		JSRR R6
		BRnzp MENU_SUB
		
		THE_END_3400
;HINT Restore
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R6, BACKUP_R6_3200
		LD R7, BACKUP_R7_3200
		RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6400
ASCII_7_3200		.FILL #-7
ASCII_48_3200		.FILL #-48
ASCII_49_3200		.FILL #-49
ASCII_55_3200		.FILL #-55
BACKUP_R3_3200		.BLKW #1
BACKUP_R4_3200		.BLKW #1
BACKUP_R6_3200		.BLKW #1
BACKUP_R7_3200		.BLKW #1
NEWLINE_3200		.FILL '\n'

FIRST_FREE_4400			.FILL x4400
MACHINE_STATUS_4200		.FILL x4200
NUM_FREE_MACHINES_4000	.FILL x4000
NUM_BUSY_MACHINES_3800	.FILL x3800
ALL_MACHINES_FREE_3600	.FILL x3600
ALL_MACHINES_BUSY_3400	.FILL x3400

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3400
;HINT back up 
		ST R1, BACKUP_R1_3400
		ST R3, BACKUP_R3_3400
		ST R7, BACKUP_R7_3400

		LD R1, BUSYNESS_ADDR_ALL_MACHINES_BUSY
		LDR R1, R1, #0
		LD R3, BIT_MASK_3400
		AND R3, R1, R3				;RESULT SHOULD BE 0000 0000 0000 0000 IF ALL ARE BUSY
		BRz MACHINE_BUSY
		BRnp OTHERWISE_3400
	MACHINE_BUSY
		LD R2, BIT_MASK_3400		;STORE 0 IN R2 IF ALL MACHINES BUSY
		ADD R2, R2, #1
		LD R0, NEWLINE_3400
		OUT
		LEA R0, allbusy_3400
		PUTS
		BRnzp END_3400
	OTHERWISE_3400
		LD R2, BIT_MASK_3400
		LD R0, NEWLINE_3400
		OUT
		LEA R0, allnotbusy_3400
		PUTS
		BRnzp END_3400

END_3400
;HINT Restore
		LD R1, BACKUP_R1_3400
		LD R3, BACKUP_R3_3400
		LD R7, BACKUP_R7_3400
		RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB200
BIT_MASK_3400	.FILL xFFFF		;
BACKUP_R1_3400	.BLKW #1
BACKUP_R3_3400	.BLKW #1
BACKUP_R7_3400	.BLKW #1
allbusy_3400        .stringz "All machines are busy\n"
allnotbusy_3400      .stringz "Not all machines are busy\n"
NEWLINE_3400		.FILL '\n'

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x3600
;HINT back up 
		ST R1, BACKUP_R1_3600
		ST R3, BACKUP_R3_3600
		ST R7, BACKUP_R7_3600

		LD R1, BUSYNESS_ADDR_ALL_MACHINES_FREE
		LDR R1, R1, #0
		LD R3, BIT_MASK_3600
		ADD R3, R1, #1
		BRz MACHINE_FREE
		BRnp OTHERWISE_3600
	MACHINE_FREE
		AND R2, R2, x0		;STORE 1 IN R2 IF ALL MACHINES FREE
		ADD R2, R2, #1
		LEA R0, allfree_3600
		PUTS
		BRnzp END_3600
	OTHERWISE_3600
		AND R2, R2, x0
		LEA R0, allnotfree_3600
		PUTS
		BRnzp END_3600
END_3600
;HINT Restore
		LD R1, BACKUP_R1_3600
		LD R3, BACKUP_R3_3600
		LD R7, BACKUP_R7_3600
			RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB200
BIT_MASK_3600	.FILL xFFFF			;
BACKUP_R1_3600	.BLKW #1
BACKUP_R3_3600	.BLKW #1
BACKUP_R7_3600	.BLKW #1
allfree_3600         .stringz "\nAll machines are free\n"
allnotfree_3600		.stringz "\nNot all machines are free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x3800
;HINT back up 
ST R0, BACKUP_R0_3800
ST R2, BACKUP_R2_3800
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800

LD R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES		;LOAD NUMBER INTO R1
LDR R1, R1, #0
AND R2, R2, x0		;ZERO R2 WHICH WILL CONTAIN NUM OF 1'S
LD R3, COUNTER


DO_LOOP_3800
		ADD R1, R1, #0	;WILL CHECK IF LEFTMOST DIG IS 1 OR 0
		BRzp IS_POS		;IF FIRST_CHAR IS 0, IT IS POSITIVE
		BRn IS_NEG		;IF FIRST CHAR IS ONE, IT IS NEGATIVE
	IS_POS				;DO NOTHING IF POS
		BRnzp NEXT_STEP
	IS_NEG
		ADD R2, R2, #1		;ACCUMULATES NUM OF 1'S/FREE MACHINES
		BRnzp NEXT_STEP
	NEXT_STEP
		ADD R1, R1, R1		;SHIFT R1
		ADD R3, R3, #-1
		BRp DO_LOOP_3800
END_DO_LOOP_3800

NOT R2, R2
ADD R2, R2, #1
LD R3, COUNTER
ADD R1, R3, R2				;SUBTRACT NUM OF FREE MACHINES FROM TOTAL NUM OF MACHINES

LEA R0, busymachine1_3800
PUTS
ADD R1, R1, #0
LD R6, PRINT_NUM_4800
JSRR R6
LEA R0, busymachine2_3800
PUTS


;HINT Restore
LD R0, BACKUP_R0_3800
LD R2, BACKUP_R2_3800
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800
RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB200
BACKUP_R0_3800	.BLKW #1
BACKUP_R2_3800	.BLKW #1
BACKUP_R6_3800	.BLKW #1
BACKUP_R7_3800	.BLKW #1
COUNTER			.FILL #16	;FOR COUNTING 16 ITERATIONS IN MY LOOP
busymachine1_3800    .stringz "\nThere are "
busymachine2_3800    .stringz " busy machines\n"
PRINT_NUM_4800		.FILL x4800

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x4000
;HINT back up 
ST R0, BACKUP_R0_4000
ST R2, BACKUP_R2_4000
ST R6, BACKUP_R6_4000
ST R7, BACKUP_R7_4000

LD R1, BUSYNESS_ADDR_NUM_FREE_MACHINES		;LOAD NUMBER INTO R1
LDR R1, R1, #0
AND R2, R2, x0		;ZERO R2 WHICH WILL CONTAIN NUM OF 1'S
LD R3, COUNTER_4000

DO_LOOP_4000
		ADD R1, R1, #0	;WILL CHECK IF LEFTMOST DIG IS 1 OR 0
		BRzp IS_POS_2	;IF FIRST_CHAR IS 0, IT IS POSITIVE
		BRn IS_NEG_2		;IF FIRST CHAR IS ONE, IT IS NEGATIVE
	IS_POS_2				;DO NOTHING IF POS
		BRnzp NEXT_STEP_2
	IS_NEG_2
		ADD R2, R2, #1		;ACCUMULATES NUM OF 1'S/FREE MACHINES
		BRnzp NEXT_STEP_2
	NEXT_STEP_2
		ADD R1, R1, R1		;SHIFT R1
		ADD R3, R3, #-1
		BRp DO_LOOP_4000
END_DO_LOOP_4000
	LEA R0, freemachine1_4000
	PUTS
	ADD R1, R2, #0
	LD R6, PRINT_NUM_4800_2
	JSRR R6
	LEA R0, freemachine2_4000
	PUTS

;HINT Restore
LD R0, BACKUP_R0_4000
LD R2, BACKUP_R2_4000
LD R6, BACKUP_R6_4000
LD R7, BACKUP_R7_4000
RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB200
BACKUP_R0_4000	.BLKW #1
BACKUP_R2_4000	.BLKW #1
BACKUP_R6_4000	.BLKW #1
BACKUP_R7_4000	.BLKW #1
COUNTER_4000	.FILL #16	;FOR COUNTING 16 ITERATIONS IN MY LOOP
PRINT_NUM_4800_2	.FILL x4800
freemachine1_4000    .stringz "\nThere are "
freemachine2_4000   .stringz " free machines\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x4200
;HINT back up 
		ST R3, BACKUP_R3_4200
		ST R4, BACKUP_R4_4200
		ST R7, BACKUP_R7_4200

		LD R6, GET_MACHINE_NUM_4600				;CALL GET MACHINE SUBROUTINE
		JSRR R6									;NUM ENTERED IS IN R1
		ADD R3, R1, #0							;COPY TO R3
		LD R4, BUSYNESS_ADDR_MACHINE_STATUS
		LDR R4, R4, #0							;GET VALUE OF R4
		
		ADD R4, R4, #0
		BRz CHECK_NUM
		
		SHIFT_4200
		ADD R4, R4, R4
		ADD R3, R3, #-1
		BRp SHIFT_4200
		
		CHECK_NUM
		ADD R4, R4, #0
		BRzp IS_BUSY
		BRn IS_FREE

	IS_FREE
		AND R2, R2, x0
		ADD R2, R2, #1						;1 IN R2 IF FREE
		LEA R0, status1_4200
		PUTS
		ADD R1, R1, #0
		LD R6, PRINT_NUM3_4800
		JSRR R6
		LEA R0, status3_4200
		PUTS
		BRnzp THE_END_4200
	IS_BUSY
		AND R2, R2, x0						;0 IN R2 IF BUSY
		LEA R0, status1_4200
		PUTS
		ADD R1, R1, #0
		LD R6, PRINT_NUM3_4800
		JSRR R6
		LEA R0, status2_4200
		PUTS
		BRnzp THE_END_4200		
			
THE_END_4200
;HINT Restore
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R7, BACKUP_R7_4200
RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xB200
GET_MACHINE_NUM_4600		.FILL x4600
PRINT_NUM3_4800				.FILL x4800
BACKUP_R3_4200				.BLKW #1
BACKUP_R4_4200				.BLKW #1
BACKUP_R7_4200				.BLKW #1
status1_4200	         	.stringz "Machine "
status2_4200		   		.stringz " is busy\n"
status3_4200		    	.stringz " is free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x4400
;HINT back up 
		ST R2, BACKUP_R2_4400
		ST R3, BACKUP_R3_4400
		ST R6, BACKUP_R6_4400
		ST R7, BACKUP_R7_4400
		
		LD R2, BUSYNESS_ADDR_FIRST_FREE
		LDR R2, R2, #0
		LD R3, COUNTER_4400

		AND R1, R1, x0
		ADD R2, R2, #0
		BRzp KEEP_SHIFTING
		BRn OUT_NUM						;IF FIRST NUM IS 1, OUT 0

KEEP_SHIFTING
		ADD R2, R2, R2	;SHIFT R2
		ADD R1, R1, #1
		ADD R2, R2, #0
		BRn OUT_NUM
		BRzp CHECK_COUNTER
	CHECK_COUNTER
		ADD R3, R3, #-1
		BRz NO_FREE
		BRnp KEEP_SHIFTING
	
	OUT_NUM
		LEA R0, firstfree1_4400
		PUTS
		ADD R1, R1, #0
		LD R6, PRINT_NUM6_4800
		JSRR R6
		LD R0, NEWLINE_4400
		OUT
		BRnzp THE_END_4400
		
	NO_FREE
		LEA R0, firstfree2_4400
		PUTS
		
THE_END_4400
;HINT Restore
LD R2, BACKUP_R2_4400
LD R3, BACKUP_R3_4400
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400
RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB200
BACKUP_R2_4400			.BLKW #1
BACKUP_R3_4400			.BLKW #1
BACKUP_R6_4400			.BLKW #1
BACKUP_R7_4400			.BLKW #1
COUNTER_4400			.FILL #-16
PRINT_NUM6_4800			.FILL x4800
firstfree1_4400      .stringz "\nThe first available machine is number "
firstfree2_4400     .stringz "\nNo machines are free\n"
NEWLINE_4400		.FILL '\n'



;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4600

	ST R3, BACKUP_R3_4600
	ST R4, BACKUP_R4_4600
	ST R5, BACKUP_R5_4600
	ST R7, BACKUP_R7_4600	
BEG_4600
LEA R0, prompt
PUTS

		LD R3, COUNTER_4600
		AND R1, R1, x0
		GETC
		OUT
		
		LD R4, ZERO_ASCII_4600			;CHECK IF SOMETHING BETWEEN #48 AND #57 WAS ENTERED
		ADD R5, R4, R0
		BRn PRINT_ERROR_4600
		BRzp NOT_NUM_FLAG2
	NOT_NUM_FLAG2
		LD R4, NINE_ASCII_4600
		ADD R5, R4, R0
		BRp PRINT_ERROR_4600
		BRnz POS_STEP

POS_STEP
			LD R4, ZERO_ASCII_4600
			ADD R0, R0, R4
			ADD R1, R1, R1
			ADD R5, R1, R1
			ADD R5, R5, R5
			ADD R1, R1, R5
			ADD R1, R0, R1
DO_POS_LOOP
			GETC
			OUT
			LD R4, NEWL_ASCII_4600
			ADD R5, R4, R0
			BRz THE_END_4600			;IF NEWLINE WAS ENTERED, STOP
			BRnp CHECK_POS_NUM
		CHECK_POS_NUM
			LD R4, ZERO_ASCII_4600
			ADD R5, R4, R0				;IF CHAR ENTERED WAS LESS THAN 48, OUT ERROR
			BRn PRINT_ERROR_4600
			BRzp NEXT_TEST
		NEXT_TEST
			LD R4, FIVE_ASCII_4600		;NEXT NUM CAN ONLY BE 0-5
			ADD R5, R4, R0
			BRp PRE_PRINT_ERROR
			BRnz STORE_POS_NUM
		STORE_POS_NUM	
			LD R4, ZERO_ASCII_4600
			ADD R0, R0, R4
			ADD R1, R1, R1
			ADD R5, R1, R1
			ADD R5, R5, R5
			ADD R1, R1, R5
			ADD R1, R0, R1

			ADD R3, R3, #-1
			BRp DO_POS_LOOP
			BRzp THE_END_4600
			END_DO_POS_LOOP
PRE_PRINT_ERROR
GETC
OUT
PRINT_ERROR_4600
		LEA R0, Error_msg_2
		PUTS
		BRnzp BEG_4600 
		


THE_END_4600	
					
	LD R3, BACKUP_R3_4600
	LD R4, BACKUP_R4_4600
	LD R5, BACKUP_R5_4600
	LD R7, BACKUP_R7_4600	
	RET
	
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "\nEnter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "\nERROR INVALID INPUT"
NEG_ASCII_4600			.FILL #-45
NEWL_ASCII_4600			.FILL #-10
NEWLINE_4600			.FILL #10
PLUS_ASCII_4600			.FILL #-43
COUNTER_4600			.FILL #2		;IF FIRST DIG WAS A NUM, ENTER 4 MORE CHARS
ZERO_ASCII_4600			.FILL #-48
NINE_ASCII_4600			.FILL #-57
FIVE_ASCII_4600			.FILL #-53
BACKUP_R5_4600			.BLKW #1
BACKUP_R4_4600			.BLKW #1
BACKUP_R3_4600			.BLKW #1
BACKUP_R7_4600			.BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
.ORIG x4800

;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
	ST R2, BACKUP_R2_4800
	ST R3, BACKUP_R3_4800
	ST R7, BACKUP_R7_4800
	
;PRINT VALUE IN R1
		ADD R2, R1, #0
		AND R0, R0, x0				;ZERO R0
		LD R4, PRINT_10
		ADD R3, R4, R2
		BRzp IS_10
		BRn IS_1
IS_10
		LD R4, PRINT_10
		ADD R2, R2, R4				;SUBTRACT 10 AND PLACE IN R2
		BRn NO_MORE_10
		BRzp CONTINUE_10
	CONTINUE_10
		ADD R0, R0, #1
		BRzp CHECK_NEXT_10
	CHECK_NEXT_10
		ADD R2, R2, R4				;SUBTRACT 10 FROM CURR VALUE
		BRn NO_MORE_10
		BRzp CONTINUE_10	;IF NUM ISN'T NEGATIVE, KEEP INCREASING R0
	NO_MORE_10
		NOT R4, R4
		ADD R4, R4, #1		;GET 1
		ADD R2, R4, R2		;RESTORE R2
		LD R4, ASCII_0_PRINT
		ADD R0, R0, R4		;ADD 48 TO R0 TO OUTPUT TO CONSOLE
		OUT
		BRnzp PRE_IS_1
	PRE_IS_1
		AND R0, R0, x0
		BRz IS_1

IS_1						;R2 CONTAINS THE VALUE I WANT TO USE TO OUTPUT THE 100S PLACE
		LD R4, PRINT_1
		ADD R2, R2, R4
		BRn NO_MORE_1
		BRzp CONTINUE_1
	CONTINUE_1
		ADD R0, R0, #1
		BRzp CHECK_NEXT_1
	CHECK_NEXT_1
		ADD R2, R2, R4		;R5-100
		BRn NO_MORE_1
		BRzp CONTINUE_1
	NO_MORE_1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R2, R2, R4			;RESTORE VALUE OF R5
		LD R4, ASCII_0_PRINT
		ADD R0, R0, R4			;ADD 48 TO OUTPUT TO CONSOLE
		OUT
		BRnzp THE_END_4800
		
		THE_END_4800

	LD R2, BACKUP_R2_4800
	LD R3, BACKUP_R3_4800
	LD R7, BACKUP_R7_4800
	RET


;--------------------------------
;Data for subroutine print number
;--------------------------------
PRINT_10		.FILL #-10
PRINT_1			.FILL #-1
ASCII_0_PRINT	.FILL #48
BACKUP_R7_4800	.BLKW #1
BACKUP_R2_4800	.BLKW #1
BACKUP_R3_4800	.BLKW #1

.ORIG x6400
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB200			; Remote data
BUSYNESS .FILL x8000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
