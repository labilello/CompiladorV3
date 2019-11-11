include macros2.asm
include number.asm

.MODEL LARGE
.STACK 200h

.386
MAXTEXTSIZE equ 50

.DATA
	_aa	dd	?
	_b	dd	?
	_a	dd	?
	_d	dd	?
	_p1	dd	?
	_p2	dd	?
	_p3	dd	?
	_p4	dd	?
	_h1	dd	?
	_h2	dd	?
	___ALTA_COMPILACION_PERRO_	db	"ALTA COMPILACION PERRO", "$"
	_constante3	db	"HOLA", "$"
	_auxFiltro	dd	?

.CODE
START:
; ******* CODIGO PERMANENTE ********
		mov AX,@DATA
		mov DS,AX
		mov es,ax
; **********************************
ETQ_0:
		GetFloat	_b	
ETQ_1:
		DisplayFloat	_b	, 2
		newLine		
ETQ_2:
		displayString	___ALTA_COMPILACION_PERRO_	
		newLine		
ETQ_4:
		mov ax, 4C00h
		int 21h
END START