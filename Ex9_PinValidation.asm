; Exercise 9: PIN Validation

COMMENT !
Your task is to create a procedure named Validate_PIN that receives a pointer to an 
array of byte containing a 5-digit PIN. Declare two arrays to hold the minimum and
maximum range values, and use these arrays to validate each digit of the PIN that 
was passed to the procedure. If any digit is found to be outside its valid range, 
immediatey return the digit's position (between 1 and 5) in the EAX register. If 
the entire PIN is valid, return 0 in EAX. Preserve all other register values between
calls to the procedure. Write a test program that calls Validate_PIN at least four 
times, using both valid and invalid byte arrays. By running the program in a debugger, 
verify that the return value in EAX after each procedure call is valid. Or, if you 
prefer to use the book's library, you can display "Valid" or "Invalid" on the console 
after each procedure call. Use this table to validate the ranges:

Digit 
Number	Range
1	    5 to 9
2	    2 to 5
3	    4 to 8
4	    1 to 4
5	    3 to 6
!

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
VALID_PIN = 0
PIN_SIZE = 5
minVals byte 5,2,4,1,3			; globally visible
maxVals byte 9,5,8,4,6			; globally visible
samplePin_1 byte 6,3,4,4,3		; valid PIN
samplePin_2 byte 5,2,3,2,4		; digit 3 is invalid
samplePin_3 byte 5,2,4,5,3		; digit 4 is invalid
samplePin_4 byte 1,3,4,4,3		; digit 1 is invalid

.code
main proc

	mov  esi,OFFSET samplePin_1
	call Validate_PIN			; EAX = VALID_PIN

	mov  esi,OFFSET samplePin_2
	call Validate_PIN			; EAX = 3

	mov  esi,OFFSET samplePin_3
	call Validate_PIN			; EAX = 4

	mov  esi,OFFSET samplePin_4
	call Validate_PIN			; EAX = 1

	invoke ExitProcess,0
main endp

Validate_PIN proc
	mov  edi,0
	mov  ecx,PIN_SIZE

L1:	mov  al,[esi]
	cmp  al,minVals[edi]
	jb   error
	cmp  al,maxVals[edi]
	ja   error
	inc	 edi
	inc  esi
	loop L1
	mov  eax,VALID_PIN	
	ret

error:
	mov eax,edi			; return position # of the bad digit
	inc eax
	ret
Validate_PIN endp


end main