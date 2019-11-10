include macros2.asm
include number.asm

.MODEL LARGE
.DATA
.STACK 200h

.386
MAXTEXTSIZE equ 50

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
; **********************************
	mov es,ax
		FLD 	_a	
		FSTP	@aux8	
		FLD 	_j	
		FSTP	@aux9	
		FLD 	_s	
		FSTP	@aux10	
		FLD 	_5_00	
		FSTP	@aux11	
		FLD 	@aux10	
		FMUL	@aux11	
		FSTP	@aux12	
		FLD 	@aux9	
		FADD	@aux12	
		FSTP	@aux13	
		FLD 	_a	
		FSTP	@aux17	
		FLD 	_25_00	
		FSTP	@aux18	
		FLD 	_i	
		FSTP	@aux19	
		FLD 	@aux18	
		FMUL	@aux19	
		FSTP	@aux20	
		FLD 	@aux17	
		FADD	@aux20	
		FSTP	@aux21	
		FLD 	_3_00	
		FSTP	@aux22	
		FLD 	_3_00	
		FSTP	@aux26	
		FLD 	_b	
		FSTP	@aux27	
		FLD 	_3_00	
		FSTP	@aux31	
		FLD 	_b	
		FSTP	@aux32	
		FLD 	_3_00	
		FSTP	@aux36	
		FLD 	_b	
		FSTP	@aux37	
		FLD 	_a	
		FSTP	@aux39	
		FLD 	_b	
		FSTP	@aux40	
		FLD 	_b	
		FSTP	@aux45	
		FLD 	_5_00	
		FSTP	@aux46	
		FLD 	_5_00	
		FSTP	@aux48	
		FLD 	_c	
		FSTP	@aux49	
		FLD 	_z2	
		FSTP	@aux54	
		FLD 	_z3	
		FSTP	@aux55	
		FLD 	_3_00	
		FSTP	@aux59	
		FLD 	_b	
		FSTP	@aux60	
		FLD 	_24_00	
		FSTP	@aux70	
		FLD 	_a	
		FSTP	@aux71	
		FLD 	@aux71	
		FSTP	_auxFiltro	
		FLD 	_b	
		FSTP	@aux76	
		FLD 	@aux76	
		FSTP	_auxFiltro	
		FLD 	_c	
		FSTP	@aux81	
		FLD 	@aux81	
		FSTP	_auxFiltro	
		FLD 	_d	
		FSTP	@aux86	
		FLD 	@aux86	
		FSTP	_auxFiltro	
		FLD 	_f	
		FSTP	@aux91	
		FLD 	@aux91	
		FSTP	_auxFiltro	
		FLD 	_g	
		FSTP	@aux96	
		FLD 	@aux96	
		FSTP	_auxFiltro	
		FLD 	_a	
		FSTP	@aux101	
		FLD 	_a	
		FSTP	@aux106	
		FLD 	_b	
		FSTP	@aux107	
		FLD 	_a	
		FSTP	@aux110	
		FLD 	_6_00	
		FSTP	@aux111	
		FLD 	_j	
		FSTP	@aux117	
		FLD 	_r	
		FSTP	@aux118	
		FLD 	_123_00	
		FSTP	@aux122	
		FLD 	_asd	
		FSTP	@aux123	
		FLD 	_t	
		FSTP	@aux128	
		FLD 	_3_00	
		FSTP	@aux129	
