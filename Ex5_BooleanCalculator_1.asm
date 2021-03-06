; Exercise 5: Boolean Calculator, Part 1

Comment !
Description: Create a program that functions as a
simple boolean calculator for 32-bit integers. It
should display a menu that asks the user to make a
selection from the following list:

1. x AND y
2. x OR y
3. NOT x
4. x XOR y
5. Exit program

When the user makes a choice, call a procedure that displays the name of the 
operation about to be performed. You must implement this procedure using the 
Table-Driven Selection technique, shown in Section 6.5.4. (We will implement 
the operations in the exercise following this one.)
!

include Irvine32.inc

.data
msgMenu BYTE "---- Boolean Calculator ----",0dh,0ah
	BYTE 0dh,0ah
	BYTE "1. x AND y"     ,0dh,0ah
	BYTE "2. x OR y"      ,0dh,0ah
	BYTE "3. NOT x"       ,0dh,0ah
	BYTE "4. x XOR y"     ,0dh,0ah
	BYTE "5. Exit program",0

msgAND BYTE "Boolean AND",0
msgOR  BYTE "Boolean OR",0
msgNOT BYTE "Boolean NOT",0
msgXOR BYTE "Boolean XOR",0

caseTable BYTE '1'				; lookup value
	DWORD AND_op				; addres of procedure
EntrySize = ($ - caseTable )
	BYTE '2'
	DWORD OR_op
	BYTE '3'
	DWORD NOT_op
	BYTE '4'
	DWORD XOR_op
	BYTE '5'
	DWORD ExitProgram
NumberOfEntries = ($ - caseTable) / EntrySize

.code
main PROC
	call Clrscr

Menu:
	mov	    edx, OFFSET msgMenu			; menu choices
	call	WriteString
	call	Crlf

L1:	call	ReadChar
	cmp	    al,'5'						; is selection valid (1-5)?
	ja	    L1							; if above 5, go back
	cmp	    al,'1'
	jb	    L1							; if below 1, go back

	call	ChooseProcedure
	jc	    quit						; exit if CF=1

	call	Crlf
	call	WriteString					; display message
	call	Crlf
	call	Crlf

	jmp	Menu							; display menu again

quit: exit

main ENDP

;------------------------------------------------
ChooseProcedure PROC
;
; Selects a procedure from the caseTable
; Receives: AL = number of procedure
; Returns: nothing
;-----------------------------------------------
	push ebx
	push ecx

	mov	ebx, OFFSET caseTable		; pointer to the table
	mov	ecx, NumberOfEntries		; loop counter

L1:	cmp	al,[ebx]					; match found?
	jne	L2						    ; no: continue
	call NEAR PTR [ebx + 1]			; yes: call the procedure
	jmp	L3

L2:	add ebx, EntrySize				; point to the next entry
	loop L1						    ; repeat until ECX = 0

L3:	pop ecx
	pop ebx

	ret
ChooseProcedure ENDP

;------------------------------------------------
AND_op PROC
;
; Receives: Nothing
; Returns: EDX = offset of message
;------------------------------------------------
	mov edx, OFFSET msgAND			; message to display

	ret

AND_op ENDP

;------------------------------------------------
OR_op PROC
;
; Receives: Nothing
; Returns: EDX = offset of message
;------------------------------------------------
	mov edx, OFFSET msgOR			; message to display

	ret

OR_op ENDP

;------------------------------------------------
NOT_op PROC
;
; Receives: Nothing
; Returns: EDX = offset of message
;------------------------------------------------
	mov edx, OFFSET msgNOT			; message to display

	ret

NOT_op ENDP

;------------------------------------------------
XOR_op PROC
;
; Receives: Nothing
; Returns: EDX = offset of message
;------------------------------------------------

	mov edx, OFFSET msgXOR			; message to display

	ret

XOR_op ENDP

;------------------------------------------------
ExitProgram PROC
;
; Receives: Nothing
; Sets CF = 1 to signal end of program
;------------------------------------------------

	stc							; CF = 1

	ret

ExitProgram ENDP

END main