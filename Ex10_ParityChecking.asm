; Exercise 10: Parity Checking

COMMENT !
Data transmission systems and file subsystems often use a form of error detection 
that relies on calculating the parity (even or odd) of blocks of data. Your task 
is to create a procedure that returns True in the EAX register if the bytes in 
an array contain even parity, or False if the parity is odd. In other words, if 
you count all the bits in the entire array, their count will be even or odd. 
Preserve all other register values between calls to the procedure. Write a test 
program that calls your procedure twice, each time passing it a pointer to an 
array and the length of the array. The procedure's return value in EAX should 
be 1 (True) or 0 (False). For test data, create two arrays containing at least 
10 bytes, one having even parity, and another having odd parity. 
!

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

True = 1
False = 0

.data
array_1 byte 41h,53h,82h,63h,41h,53h,82h,63h,81h,11h     ; even parity
array_1_size = $ - array_1

array_2 byte 41h,83h,03h,93h,41h,84h,03h,93h,81h,11h    ; odd parity (83h)
array_2_size = $ - array_2
.code
main proc

	mov  ecx,array_1_size
	mov  esi,OFFSET array_1
	call CheckEvenParity			; returns EAX = True
		
	mov  ecx,array_2_size
	mov  esi,OFFSET array_2
	call CheckEvenParity			; returns EAX = False

	invoke ExitProcess,0
main endp

CheckEvenParity proc
	
	mov al,[esi]	; first character
	xor	al,al		; affects the Parity flag
	pushf			; push the flags
	inc esi			; affects PF
	dec ecx
	popf

L1:	xor al,[esi]	; affects the Parity flag
	pushf
	inc	esi
	popf
	loop L1			; does not affect PF

	jp	return_true
	mov	eax,False		; return False
	ret

return_true:
	mov	eax,True
	ret
CheckEvenParity endp

end main