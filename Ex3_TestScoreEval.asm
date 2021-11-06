; Exercise 3: Test Score Evaluation

Comment !
Create a procedure named CalcGrade that receives an integer value 
between 0 and 100, and returns a single capital letter in the AL 
register. Preserve all other register values between calls to the 
procedure. The letter returned by the procedure should be according 
to the following ranges:

Score Range  Letter Grade
-------------------------
90 to 100        A
80 to  89        B
70 to  79        C
60 to  69        D
 0 to  59        F

Write a test program that generates 10 random integers between 50 and 100, 
inclusive. Each time an integer is generated, pass it to the CalcGrade 
procedure.  You can test your program using a debugger, or if you prefer 
to use the book's library, you can display each integer and its corresponding 
letter grade.
!

include Irvine32.inc

.data
str1 BYTE ": The letter grade is ",0
grade BYTE ?

.code
main PROC
    call    Randomize

    mov     ecx,10             ; repeat loop 10 times
again:
    push    ecx                ; save loop counter
    mov     eax,51
    call    RandomRange        ; value [0..50]
    add     eax,50             ; becomes [50..100]
    call    WriteDec           ; optional print statement

    call    CalcGrade          ; returns the grade in AL
    mov     grade,al

    ; Print the grade (optional)

    mov	    edx,OFFSET str1	; ": The letter grade is "
	call	WriteString		
	mov     al,grade
	call	WriteChar			; display grade letter (AL)
	call	Crlf

    pop     ecx                 ; restore the loop counter
    loop    again

	exit
main ENDP

CalcGrade proc
; Calculates a letter grade
; Receives: EAX = numeric grade
; Returns:  AL = letter grade

Grade_A:
	cmp	eax,90
	jb	Grade_B
	mov	al,'A'
	jmp	finished

Grade_B:
	cmp	eax,80
	jb	Grade_C
	mov	al,'B'
	jmp	finished
	
Grade_C:
	cmp	eax,70
	jb	Grade_D
	mov	al,'C'
	jmp	finished

Grade_D:
	cmp	eax,60
	jb	Grade_F
	mov	al,'D'
	jmp	finished

Grade_F:
	mov	al,'F'

finished:
    ret
CalcGrade endp

END main



