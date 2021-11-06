; Exercise 8: Message Encryption

Comment !
This program demonstrates simple symmetric encryption using 
the XOR instruction.Let the user enter a multi-byte key. Use 
this key to encrypt and decrypt the plaintext.
!

include Irvine32.inc
BUFMAX = 128     	; maximum buffer size
KEYMAX = 128     	; maximum key size

.data
prompt1  BYTE  "Enter the plain text: ",0
prompt2  BYTE  "Enter the encryption key: ",0

sEncrypt BYTE  "Cipher text:         ",0
sDecrypt BYTE  "Decrypted:           ",0

keyStr   BYTE   KEYMAX+1 DUP(0)
keySize  DWORD  ?
buffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?

.code
main PROC
	call	InputPlaintext			; input the plain text
	call	InputKey				; input the key
	call	TranslateBuffer			; encrypt the buffer
	mov	    edx,OFFSET sEncrypt		; display encrypted message
	call	DisplayMessage
	call	TranslateBuffer  		; decrypt the buffer
	mov	    edx,OFFSET sDecrypt		; display decrypted message
	call	DisplayMessage

	exit
main ENDP

;-----------------------------------------------------
InputPlaintext PROC
;
; Asks the user to enter a string from the
; keyboard. Saves the string and its length
; in variables.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	    edx,OFFSET prompt1			; display a prompt
	call	WriteString
	mov	    ecx,BUFMAX				    ; maximum character count
	mov	    edx,OFFSET buffer   		; point to the buffer
	call	ReadString         			; input the string
	mov	    bufSize,eax        			; save the length
	call	Crlf
	popad
	ret
InputPlaintext ENDP

;-----------------------------------------------------
InputKey PROC
;
; Asks the user to enter a string that will be used as 
; the encryption key. 
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	    edx,OFFSET prompt2			; display a prompt
	call	WriteString
	mov	    ecx,KEYMAX				    ; maximum character count
	mov	    edx,OFFSET keyStr   		; point to the buffer
	call	ReadString         			; input the string
	mov	    keySize,eax        			; save the length
	call	Crlf
	popad
	ret
InputKey ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	mov	    edx,OFFSET buffer		; display the buffer
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each buffer
; byte with a coresponding byte in the encryption key.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	ecx,bufSize		; loop counter
	mov	esi,0			; index 0 in the buffer
	mov	edi,0			; index 0 in the key
		
L1:	mov	al,keyStr[edi]	; get key byte
	xor	buffer[esi],al	; translate a byte
	inc	esi				; point to next byte in buffer
	inc	edi				; point to next key byte
	cmp	edi,keySize		; key index <= key size?
	jb	L2				; yes, skip to LOOP instruction
	mov	edi,0			; no: reset key index to 0
L2:	loop L1				; repeat the loop

	popad
	ret
TranslateBuffer ENDP
END main