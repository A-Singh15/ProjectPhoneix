; Exercise 7: Probabilities and Colors

Comment !
Write a program that randomly chooses between three
different colors for displaying text on the screen. Use a loop to
display twenty lines of text, each with a randomly chosen color.
The probabilities for each color are to be as follows: white = 30%,
blue = 10%, green = 60%. Hint: generate a random integer between
0 and 9. If the resulting integer is in the range 0-2, choose white.
If the integer equals 3, choose blue. If the integer is in the
range 4-9, choose green.
!

include Irvine32.inc

.data
msg BYTE "Line of text with randomly chosen color",0

.code
main PROC

	call ClrScr
	call Randomize				; seed the random number generator

	mov	edx, OFFSET msg		    ; line of text
	mov	ecx, 20				    ; counter (lines of text)

L1:	call ChooseColor
	call SetTextColor
	call WriteString			; display line of text
	call Crlf
	loop L1

	exit

main ENDP

;------------------------------------------------
ChooseColor PROC
;
; Selects a color with the following probabilities:
; white = 30%, blue = 10%, green = 60%.
; Receives: nothing
; Returns: EAX = selected color
;-----------------------------------------------

	mov	eax, 10		; generate random (0-9)
	call RandomRange	; EAX = random value
	
L_Green:				; if N = 4-9, choose green
	cmp	eax,4
	jb	L_Blue
	mov	eax,green
	jmp	L_Finished

L_Blue:				    ; if N = 3, choose blue
	cmp	eax,3
	jne	L_White
	mov	eax,blue
	jmp	L_Finished
	
L_White:				; if N = 0-2, choose white
	mov	eax,white	

L_Finished:
	ret

ChooseColor ENDP

END main