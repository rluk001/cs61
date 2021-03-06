;=================================================
; Name: Luk, Ryan
; Username: rluk001
; Lab: Lab 06
; Lab section: 022
; TA: Bryan Marsh
;=================================================

.orig x3000
LEA R0, string
PUTS

LD R1, ABCD
LD R6, SUB_INPUT
JSRR R6

LD R0, newLine
OUT

LEA R0, string2
PUTS

LD R3, zeroes

LD R6, SUB_RSHIFT
JSRR R6

LD R6, SUB_INPUT
JSRR R6

LD R0, newLine
OUT

HALT
SUB_INPUT .FILL x3200
SUB_RSHIFT .FILL x3400
ABCD .FILL xABCD
newLine .FILL x0A
zeroes .FILL #0
string .STRINGZ "xABCD is b"
string2 .STRINGZ "x55E6 is b"

.orig x3200

ST R1, BACKUP_R1_3200
ST R7, BACKUP_R7_3200

LD R5, COUNT
LD R4, NUM

ADD R3, R3, #0
BRz loop

ADD R1, R3, #0

loop
	ADD R1, R1, #0
	BRn ELSE_IF			; Goes to ELSE_IF if MSB is negative
IF_STATEMENT
	LD R0, ZERO 		; Prints out '0'
	OUT 				; Output
	BR NEXT 			; Goes to the NEXT branch
ELSE_IF
	LD R0, ONE 			; Prints out '1'
	OUT  				; Output
NEXT	
	ADD R1, R1, R1 		; Left shifting
	ADD R2, R2, #1 		; Adds a secondary count for spaces		
	ADD R4, R2, #0 		; Saves R2's data into R4
	SECOND_IF
		BRp POS_IF 		; Branch if LMR is positive
		BRn NEG_IF 		; Branch if LMR is negative
		BRz ZERO_IF 	; Branch if LMR is zero
	POS_IF
		ADD R2, R2, -4 	; Subtracts 4 from the number
		BR SECOND_IF 	; Sends it back to the loop to check if NZP
	NEG_IF
		ADD R2, R4, #0 	; Returns R2's data with its original data
		BR SECOND_IF_END 	; Ends the loop
	ZERO_IF
		LD R0, SPACE 	; Prints out a space if 4 bits have been printed out
		OUT 			; Output
		ADD R2, R4, #0 	; Return R2's data with its original data
	SECOND_IF_END
	ADD R5, R5, -1 		; Decrements count
	BRp loop			; Repeat through loop, until it stops at 0
loop_END 				; End of loop

LD R1, BACKUP_R1_3200
LD R7, BACKUP_R7_3200
RET

COUNT .FILL #16
ZERO .FILL #48
ONE .FILL #49
SPACE .FILL #32
BACKUP_R1_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1
NUM .FILL #0

.orig x3400

ST R1, BACKUP_R1_3400
ST R7, BACKUP_R7_3400

LD R5, COUNT2

loop2
	ADD R3, R3, R3
	ADD R1, R1, #0
	BRn next
	BR skip
	next
		ADD R3, R3, #1
	skip
	ADD R1, R1, R1
	ADD R5, R5, #-1
	BRp loop2
loop2_END 				

LD R1, BACKUP_R1_3400
LD R7, BACKUP_R7_3400
RET

COUNT2 .FILL #15
BACKUP_R1_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1

.END
