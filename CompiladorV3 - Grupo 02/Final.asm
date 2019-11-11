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
	_constante1	dd	2.00
	_constante2	dd	0.5
	_constante3	db	"HOLA", "$"
	__2147483_00	dd	2147483.00
	_string1	db	"ASD ASD AAASSD", "$"
	__2_00	dd	2.00
	__0_50	dd	0.50
	__5_00	dd	5.00
	__25_00	dd	25.00
	__3_00	dd	3.00
	__52_00	dd	52.00
	__125_00	dd	125.00
	_constante5	db	"1113333333", "$"
	__"HOLA"	db	"HOLA", "$"
	__24_00	dd	24.00
	__6_00	dd	6.00
	__"1"	db	"1", "$"
	__"2"	db	"2", "$"
	__"3"	db	"3", "$"
	__123_00	dd	123.00
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
		FLD 	_"HOLA"	
		FSTP	_constante3	
		FLD 	_a	
		FSTP	_aa	
		FLD 	_2147483_00	
		FSTP	_d	
		FLD 	_"ASD ASD AAASSD"	
		FSTP	_string1	
		FLD 	_0_50	
		FSTP	_p4	
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
		FLD 	_52_00	
		FSTP	_b	
		FLD 	_z2	
		FSTP	@aux54	
		FLD 	_z3	
		FSTP	@aux55	
		FLD 	_125_00	
		FSTP	_b	
		FLD 	_3_00	
		FSTP	@aux59	
		FLD 	_b	
		FSTP	@aux60	
		FLD 	_"1113333333"	
		FSTP	_constante5	
		FLD 	_24_00	
		FSTP	@aux70	
		FLD 	_a	
		FSTP	@aux71	
		FLD 	@aux71	
		FSTP	_auxFiltro	
		FLD 	_[ 71 ]	
		FSTP	__auxFiltro	
		FLD 	_b	
		FSTP	@aux76	
		FLD 	@aux76	
		FSTP	_auxFiltro	
		FLD 	_[ 76 ]	
		FSTP	__auxFiltro	
		FLD 	_c	
		FSTP	@aux81	
		FLD 	@aux81	
		FSTP	_auxFiltro	
		FLD 	_[ 81 ]	
		FSTP	__auxFiltro	
		FLD 	_d	
		FSTP	@aux86	
		FLD 	@aux86	
		FSTP	_auxFiltro	
		FLD 	_[ 86 ]	
		FSTP	__auxFiltro	
		FLD 	_f	
		FSTP	@aux91	
		FLD 	@aux91	
		FSTP	_auxFiltro	
		FLD 	_[ 91 ]	
		FSTP	__auxFiltro	
		FLD 	_g	
		FSTP	@aux96	
		FLD 	@aux96	
		FSTP	_auxFiltro	
		FLD 	_[ 96 ]	
		FSTP	__auxFiltro	
		FLD 	_a	
		FSTP	@aux101	
		FLD 	_3_00	
		FSTP	_b	
		FLD 	_5_00	
		FSTP	_b	
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
