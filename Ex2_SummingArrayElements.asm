; Exercise 2: Summing Array Elements in a Range

COMMENT !
Create a procedure that returns the sum of all array elements falling 
within the range j..k (inclusive) . Write a test program that calls 
the procedure twice, passing a pointer to a signed doubleword array, the 
size of the array, and the values of j and k. Return the sum in 
the EAX register.
!

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
lowerLimit dword 20
upperLimit dword 40
array_1 sdword 10,30,25,15,17,19,40,41,43       ; sum: 5Fh (95)
count_1 = LENGTHOF array_1
array_2 sdword 10,-30,25,15,-17,55,40,41,43     ; sum: 41h (65)
count_2 = LENGTHOF array_2

.code
main proc
	mov     ebx,lowerLimit
	mov     edx,upperLimit
	mov     esi,OFFSET array_1
	mov     ecx,count_1
	call    CalcSumRange        ; returns sum in EAX
	call    CalcSumRange        ; call second time to see if registers are preserved
    
	mov     esi,OFFSET array_2
	mov     ecx,count_2
	call    CalcSumRange        ; returns sum in EAX
    
	invoke ExitProcess,0
main endp

CalcSumRange proc
.data
sum sdword ?
.code
; Input parameters: 
;	[EBX,EDX] = inclusive range
;	ESI = points to the array
;	ECX = array size
; Returns: EAX = sum
    push esi
    push ecx
    mov  sum,0

L1: mov  eax,[esi]    ; get next value
    cmp  eax,ebx      ; check lower limit
    jl   next
    cmp  eax,edx      ; check upper limit
    jg   next
    add  sum,eax      ; must be in range
next:
    add  esi,4        ; move to next element
    loop L1           ; continue loop

    mov  eax,sum      ; return value in EAX
    pop  ecx
    pop  esi
	ret
CalcSumRange endp

end main