include macros2.asm
include number.asm

.MODEL LARGE
.386
.STACK 200h

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
	_constante1	dd	2.00
	_constante2	dd	0.5
	_constante3	db	"HOLA", "$"
	__2147483.00	dd	2147483.00
	_string1	db	"ASD ASD AAASSD", "$"
	__2.00	dd	2.00
	__0.50	dd	0.50
	__5.00	dd	5.00
	__25.00	dd	25.00
	__3.00	dd	3.00
	__52.00	dd	52.00
	__125.00	dd	125.00
	_constante5	db	"1113333333", "$"
	__"HOLA"	db	"HOLA", "$"
	__24.00	dd	24.00
	__6.00	dd	6.00
	__"1"	db	"1", "$"
	__"2"	db	"2", "$"
	__"3"	db	"3", "$"
	__123.00	dd	123.00
	__"4"	db	"4", "$"
	__"5"	db	"5", "$"
	__"5b"	db	"5b", "$"

.CODE
START:
; ******* CODIGO PERMANENTE ********
	mov AX,@DATA
	mov DS,AX
	mov es,ax
; **********************************
