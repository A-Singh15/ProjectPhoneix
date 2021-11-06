; Exercise 1: Filling an Array

Comment !
Create a procedure that fills an array of doubleword with N random integers, making 
sure the values fall within the range j..k. When calling the procedure, pass a 
pointer to the array that will hold the data, pass N, and pass the values of j 
and k. Write a test program that calls the procedure twice, using different 
values for N, j, and k.
!

INCLUDE Irvine32.inc

.data
intArray sdword 50 DUP(?)
count DWORD 0

.code
main PROC
	call Randomize
	
	mov  esi,OFFSET intArray 		; point to the array
	mov  ecx,LENGTHOF intArray 		; N
	mov	 ebx,10						; lower limit (j)
	mov  eax,20						; upper limit (k)
	call FillRandom

	mov  ebx,5
	mov  eax,50						; upper limit (k)
	call FillRandom
	
	exit
main ENDP

FillRandom proc
; Input parameters:
; ESI points to the array, ECX is the size
; EBX = lower base, EAX = upper limit	
	pushad

	sub		eax,ebx			; calculate interval size
	inc		eax

L1:	push	eax				; save the interval size
	call	RandomRange		; generates value (0 to EAX-1)
	add	    eax,ebx			; add it to the base
	mov		[esi],eax
	pop		eax
	add		esi,4
	loop	L1

	popad
	ret
FillRandom endp

END main