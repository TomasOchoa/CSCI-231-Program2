;// PROGRAM 2
;//
;// AUTHOR: TOMAS OCHOA
;// DUE DATE: 8 October 2015
;// TITLE: CopyString.asm
;// PURPOSE: Copy and reverse a source string
INCLUDE Irvine32.inc


.386
.model	flat, stdcall
.stack 	4096
ExitProcess proto, dwExitCode:dword

.data
source	BYTE "This is the source string",0		;// set source to be a string
target	BYTE SIZEOF source DUP('#')				;// set the size of target to that of the source
.code
main proc

;// Display original string
mov		edx, OFFSET source						
call 	WriteString

CALL 	Crlf				;// endl

;//Reset registers
mov 	eax, 0
mov 	ebx, 0
mov 	ecx, 0
mov 	edx, 0
mov 	esi, 0
mov 	edi, 0
 
;//First thing to do
mov 	ecx, LENGTHOF source			  ;//initialize loop counter to source since source => target => #s of elements in string                                             
mov 	esi, OFFSET   target - 2 		  ;//esi - address of last character  [i][n][g][''][0] (we want to start at [g])          
mov 	edi, OFFSET   target   			  ;//edi - address of last character target 

;//Loop to copy source to target and reverse the strings
L1:
	mov 	eax, [esi]		;// Store the content of current value esi to eax
	mov 	[edi], eax		;// Change the content inside the current edi to current content of eax
	dec 	esi				;// Change esi to the previous address of source (so address - 1)
	inc 	edi				;// Change edi to the next address target (so address + 1)
LOOP L1			;// go to next loop cycle

	;// Displayhexadecimal contents of the target string
	mov 	esi, OFFSET target 
	mov 	ebx, 1 
	mov 	ecx, SIZEOF target 
	call 	DumpMem 	

	CALL 	Crlf				;// endl
	
invoke 		ExitProcess, 0
main 		endp
end 		main