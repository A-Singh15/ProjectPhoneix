; Exercise 4: College Registration

Comment !
Using the College Registration example from
Section 6.7.2.2 as a starting point, do the following:
 Recode the logic using CMP and conditional jump
instructions (instead of the .IF and .ELSEIF directives).
Perform range checking on the credits value; it cannot
be less than 1 or greater than 30. If an invalid entry
is discovered, display an appropriate error message.
!
include Irvine32.inc

TRUE  = 1
FALSE = 0

.data
gradeAverage  DWORD ?
credits       DWORD ?
OkToRegister  DWORD ?
str1 BYTE "Error: Credits must be between 1 and 30",0dh,0ah,0
str2 BYTE "Enter the grade average [0 - 400]: ",0
str3 BYTE "Enter the requested number of credits: ",0
str4 BYTE "The student can register",0dh,0ah,0
str5 BYTE "The student cannot register",0dh,0ah,0

.code
main PROC

	call GetUserInput
	call CheckRegistration
	call ShowResults

	exit
main ENDP

;-----------------------------------------------
GetUserInput PROC
;-----------------------------------------------
	pushad

	; ask for the grade average

	mov	edx,OFFSET str2
	call	WriteString
	call	Crlf
	call	ReadInt
	mov	gradeAverage,eax
	
	; ask for the number of credits

	mov	edx,OFFSET str3
	call	WriteString
	call	Crlf
	call	ReadInt
	mov	credits,eax
	
	popad
	ret
GetUserInput ENDP

;-----------------------------------------------
ShowResults PROC
;-----------------------------------------------
	pushad

	cmp   OkToRegister,TRUE
	jne   L2

L1:	mov   edx,offset str4		; can register
	call  WriteString
	jmp   L3

L2:	mov   edx,offset str5		; cannot register
	call  WriteString

L3:	popad
	ret
ShowResults ENDP

;-----------------------------------------------
CheckRegistration PROC
;
; Evaluates the gradeAverage and number of
; credits, and sets the value of OkToRegister.
; Displays an error message if credits are
; not in the range 1-30.
; Receives: nothing
; Returns: sets boolean value of OkToRegister
;-----------------------------------------------
	push	edx
	mov	OkToRegister,FALSE

; Check credits for valid range 1-30
	cmp	credits,1				; credits < 1?
	jb	E1
	cmp	credits,30			; credits > 30?
	ja	E1
	jmp	L1					; credits are ok

; Display error message: credits out of range
E1:	mov	edx,OFFSET str1
	call	WriteString
	jmp	L4

; Evaluate gradeAverage and credits, using the logic
; found in Section 6.7.2.2
L1:	cmp gradeAverage,350		; if gradeAverage > 350
	jna	L2
	mov	OkToRegister,TRUE		; OkToRegister = TRUE
	jmp	L4

L2:	cmp gradeAverage,250		; elseif gradeAverage > 250
	jna	L3
	cmp	credits,16			;   && credits <= 16
	jnbe	L3
	mov	OkToRegister,TRUE		; OKToRegister = TRUE
	jmp	L4

L3:	cmp credits,12				; elseif credits <= 12
	ja	L4
	mov	OkToRegister,TRUE		; OKToRegister = TRUE

L4:	pop	edx					; endif
	ret
CheckRegistration ENDP

END main