; Solutions to Chapter 6 Review Questions

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

; ********* Short-Answer Questions *********

.code
main proc
    call  ShortAnswer
    call  Workbench			; skip all the short-answer exercises
    invoke ExitProcess,0
main endp
 
ShortAnswer proc    

 ; Exercise 1

 mov bx,0FFFFh
and bx,6Bh

 ; Exercise 2
 mov bx,91BAh
and bx,92h

 ; Exercise 3
 mov bx,0649Bh
or bx,3Ah

 ; Exercise 4
 mov bx,029D6h
xor bx,8181h

 ; Exercise 5
 mov ebx,0AFAF649Bh
or ebx,3A219604h

 ; Exercise 6

	mov ebx,0AFAF649Bh
	xor ebx,0FFFFFFFFh
	   
 ; Exercise 7

    mov  al,01101111b
    and  al,00101101b 		    ; a.
    mov  al,6Dh
    and  al,4Ah 				; b.
    mov  al,00001111b
    or   al,61h 				; c.
    mov  al,94h
    xor  al,37h 				; d.
	
; Exercise 8

    mov  al,7Ah
    not  al 				; a.
    mov  al,3Dh
    and  al,74h 			; b.
    mov  al,9Bh
    or   al,35h 			; c.
    mov  al,72h
    xor  al,0DCh 			; d.

; Exercise 9

    mov  al,00001111b
    test al,00000010b 		; a. CF= 	ZF= 	SF=
    mov  al,00000110b
    cmp  al,00000101b 		; b. CF= 	ZF= 	SF=
    mov  al,00000101b
    cmp  al,00000111b 		; c. CF= 	ZF= 	SF=

; Exercise 10:  JECXZ

; Exercise 11: JA and JNBE clear both the Carry flag and the Zero flag

; Exercise 12:			Answer = 1
    mov  edx,1
    mov  eax,7FFFh
    cmp  eax,8000h
    jl   L1
    mov  edx,0
L1:
    
; Exercise 13: Answer = 1
    mov  edx,1
    mov  eax,7FFFh
    cmp  eax,8000h
    jb   L2
    mov  edx,0
L2:

; Exercise 14: Answer = 0
    mov  edx,1
    mov  eax,7FFFh
    cmp  eax,0FFFF8000h
    jl   L3
    mov  edx,0
L3:
    
; Exercise 15:	True
    mov  eax,-30
    cmp  eax,-50
    jg   Target     ; jump is taken
    mov  eax,eax
Target:

; Exercise 16:	True
    mov  eax,-42
    cmp  eax,26
    ja   Target2     ; jump is taken
    mov  eax,eax

Target2:    
    ret
ShortAnswer endp

; ******** ALGORITHM WORKBENCH *********

Workbench proc
; Exercise 1: 
    mov al,'A'
    and al,0Fh

; Exercise 2:
.data
memVal DWORD ?
.code
    mov al,BYTE PTR memVal
    xor al,BYTE PTR memVal+1
    xor al,BYTE PTR memVal+2
    xor al,BYTE PTR memVal+3

; Exercise 3: 
.data
SetX DWORD ?
SetY DWORD ?
.code
    mov  eax,SetX
    xor  eax,SetY       ; remove all SetY from SetX

; Exercise 4: 
    cmp  dx,cx
    jbe  L1

L1:

; Exericse 5:
    cmp ax,cx
    jg  L2

L2:

; Exercise 6:
    and  al,00000011b
    jz   L3
    jmp  L4
    mov  edx,0
L3:
L4:

;    call    Exercise7
;    call    Exercise8
;    call    Exercise9
    call    Exercise10

    ret
Workbench endp

.data
X dword ?
val1 word ?

.code
Exercise7 proc
    cmp val1,cx
    jna L1
    cmp cx,dx
    jna L1
    mov X,1
    jmp next
L1: mov X,2
next:
    ret
Exercise7 endp

Exercise8 proc
    cmp bx,cx
    ja  L1
    cmp bx,val1
    ja  L1
    mov X,2
    jmp next
L1: mov X,1
next:
    ret
Exercise8 endp

Exercise9 proc
.code
    cmp bx,cx           ; bx > cx?
    jna L1              ; no: try condition after OR
    cmp bx,dx           ; yes: is bx > dx?
    jna L1              ; no: try condition after OR
    jmp L2              ; yes: set X to 1

    ;-----------------OR(dx > ax) ------------------------
L1: cmp dx,ax           ; dx > ax?
    jna L3              ; no: set X to 2

L2: mov X,1             ; yes:set X to 1
    jmp next            ; and quit

L3: mov X,2             ; set X to 2
next:
    ret
Exercise9 endp

Exercise10Test proc
; use these registers to hold the logical variables:
    mov  eax,4      ; A
    mov  ebx,5      ; B
    mov  edx,10     ; N
    call Exercise10Test
    ret
Exercise10Test endp

Exercise10 proc
whileloop:
    cmp  edx,0
    jle  endwhile
    cmp  edx,3          ;  if N != 3
    je   elselabel
    ; check N < eax OR N > ebx
    cmp  edx,eax        ; N < A?
    jl   orlabel        ; if true, jump
    cmp  edx,ebx        ; or N > B?
    jg   orlabel        ; if true, jump
    jmp  elselabel
orlabel:
    sub  edx,2
    jmp  whileloop
elselabel:
    sub  edx,1
    jmp  whileloop
endwhile:
    ret
Exercise10 endp


end main