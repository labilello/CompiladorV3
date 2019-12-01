include macros2.asm
include number.asm

.MODEL LARGE
.STACK 200h

.386
MAXTEXTSIZE equ 50

.DATA
	_f1	dd	?
	_f2	dd	?
	_f3	dd	?
	_f4	dd	?
	_f5	dd	?
	_f6	dd	?
	_f7	dd	?
	_i1	dd	?
	_i2	dd	?
	_i3	dd	?
	_i4	dd	?
	_i5	dd	?
	_i6	dd	?
	_i7	dd	?
	_constante1	dd	2.00
<<<<<<< Updated upstream
	___F1__	db	"F1 ", "$"
	___F2__	db	"F2 ", "$"
	__3_00	dd	3.00
	__5_00	dd	5.00
	__10_00	dd	10.00
	__15_00	dd	15.00
	_auxFiltro	dd	?
	@aux0	dd	?
	@aux1	dd	?
	@aux2	dd	?
	@aux3	dd	?
	@aux4	dd	?
	@aux5	dd	?
	@aux6	dd	?
	@aux7	dd	?
	@aux8	dd	?
	@aux9	dd	?
	@aux10	dd	?
	@aux11	dd	?
	@aux12	dd	?
	@aux13	dd	?
	@aux14	dd	?
	@aux15	dd	?
	@aux16	dd	?
	@aux17	dd	?
	@aux18	dd	?
	@aux19	dd	?
	@aux20	dd	?
=======
	_constante2	dd	0.5
	_HOLA	db	"HOLA", $
	__2147483_00	dd	2147483.00
	_ASD ASD AAASSD	db	"ASD ASD AAASSD", $
	__2_00	dd	2.00
	__0_50	dd	0.50
	__5_00	dd	5.00
	__25_00	dd	25.00
	__3_00	dd	3.00
	__52_00	dd	52.00
	__125_00	dd	125.00
	_1113333333	db	"1113333333", $
	_HOLA	db	"HOLA", $
	__24_00	dd	24.00
	__6_00	dd	6.00
	_1	db	"1", $
	_2	db	"2", $
	_3	db	"3", $
	__123_00	dd	123.00
	_4	db	"4", $
	_5	db	"5", $
	_5b	db	"5b", $
>>>>>>> Stashed changes

.CODE
START:
; ******* CODIGO PERMANENTE ********
		mov AX,@DATA
		mov DS,AX
		mov es,ax
; **********************************
<<<<<<< Updated upstream
ETQ_1:
		displayString	___F1__	
		newLine		
ETQ_2:
		GetFloat	_i1	
ETQ_3:
		displayString	___F2__	
		newLine		
ETQ_4:
		GetFloat	_f2	
ETQ_5:
		;ETQ_REPEAT		
ETQ_6:
		FLD	__3_00	
		FSTP	_f1	
ETQ_7:
		FLD	__5_00	
		FSTP	_i1	
ETQ_8:
		;ETQ_REPEAT		
ETQ_9:
		DisplayFloat	_f1	, 2
		newLine		
ETQ_10:
		DisplayFloat	_i1	, 2
		newLine		
ETQ_11:
		GetFloat	_i3	
ETQ_12:
		FLD	_i3	
=======
	mov es,ax
ETQ_REPEAT_64
ETQ_REPEAT_65
		FLD 	_2_00	
		FSTP	_constante1	
		FLD 	_0_5	
		FSTP	_constante2	
		FLD 	_a	
		FSTP	_aa	
		FLD 	_2147483_00	
		FSTP	_d	
		FLD 	_2_00	
		FSTP	_h2	
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
>>>>>>> Stashed changes
		FSTP	@aux12	
ETQ_13:
		FLD	__10_00	
		FSTP	@aux13	
ETQ_14:
		FLD	@aux12	
		FCOMP	@aux13	
<<<<<<< Updated upstream
		FSTSW	ax	
		SAHF		
ETQ_15:
		JNA	ETQ_9	
ETQ_16:
		GetFloat	_i2	
ETQ_17:
		FLD	_i2	
=======
		FSTSW	AX	
		SAHF		
		JB	ETQ_17	
		FLD 	_2_00	
		FSTP	_aa	
ETQ_17
		FLD 	_a	
>>>>>>> Stashed changes
		FSTP	@aux17	
ETQ_18:
		FLD	__15_00	
		FSTP	@aux18	
<<<<<<< Updated upstream
ETQ_19:
		FLD	@aux17	
		FCOMP	@aux18	
		FSTSW	ax	
		SAHF		
ETQ_20:
		JNAE	ETQ_6	
ETQ_21:
		mov ax, 4C00h
		int 21h
END START
=======
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
		FLD 	@aux21	
		FCOMP	@aux22	
		FSTSW	AX	
		SAHF		
		JA	ETQ_26	
		FLD 	_2_00	
		FSTP	_aa	
ETQ_26
		FLD 	_3_00	
		FSTP	@aux26	
		FLD 	_b	
		FSTP	@aux27	
		FLD 	@aux26	
		FCOMP	@aux27	
		FSTSW	AX	
		SAHF		
		JBE	ETQ_31	
		FLD 	_2_00	
		FSTP	_h2	
ETQ_31
		FLD 	_3_00	
		FSTP	@aux31	
		FLD 	_b	
		FSTP	@aux32	
		FLD 	@aux31	
		FCOMP	@aux32	
		FSTSW	AX	
		SAHF		
		JAE	ETQ_36	
		FLD 	_2_00	
		FSTP	_h2	
ETQ_36
		FLD 	_3_00	
		FSTP	@aux36	
		FLD 	_b	
		FSTP	@aux37	
		FLD 	@aux36	
		FCOMP	@aux37	
		FSTSW	AX	
		SAHF		
		FLD 	_a	
		FSTP	@aux39	
		FLD 	_b	
		FSTP	@aux40	
		FLD 	@aux39	
		FCOMP	@aux40	
		FSTSW	AX	
		SAHF		
		JZ	ETQ_45	
		FLD 	_2_00	
		FSTP	_h2	
ETQ_45
		FLD 	_b	
		FSTP	@aux45	
		FLD 	_5_00	
		FSTP	@aux46	
		FLD 	@aux45	
		FCOMP	@aux46	
		FSTSW	AX	
		SAHF		
		FLD 	_5_00	
		FSTP	@aux48	
		FLD 	_c	
		FSTP	@aux49	
		FLD 	@aux48	
		FCOMP	@aux49	
		FSTSW	AX	
		SAHF		
		JZ	ETQ_59	
		FLD 	_z2	
		FSTP	@aux54	
		FLD 	_z3	
		FSTP	@aux55	
		FLD 	@aux54	
		FCOMP	@aux55	
		FSTSW	AX	
		SAHF		
		JAE	ETQ_59	
ETQ_59
		FLD 	_3_00	
		FSTP	@aux59	
		FLD 	_b	
		FSTP	@aux60	
		FLD 	@aux59	
		FCOMP	@aux60	
		FSTSW	AX	
		SAHF		
		JBE	ETQ_REPEAT64	
		FLD 	_2_00	
		FSTP	_h2	
ETQ_REPEAT_64
ETQ_REPEAT_65
		displayString	_constante3	
		newLine		
		GetFloat	_	
		DisplayFloat	_	, 2
		newLine		
		FLD 	_24_00	
		FSTP	@aux70	
		FLD 	_a	
		FSTP	@aux71	
		FLD 	@aux70	
		FCOMP	@aux71	
		FSTSW	AX	
		SAHF		
		JB	ETQ_76	
		FLD 	@aux71	
		FSTP	_auxFiltro	
		JMP	ETQ_101	
ETQ_76
		FLD 	_b	
		FSTP	@aux76	
		FLD 	@aux70	
		FCOMP	@aux76	
		FSTSW	AX	
		SAHF		
		JB	ETQ_81	
		FLD 	@aux76	
		FSTP	_auxFiltro	
		JMP	ETQ_101	
ETQ_81
		FLD 	_c	
		FSTP	@aux81	
		FLD 	@aux70	
		FCOMP	@aux81	
		FSTSW	AX	
		SAHF		
		JB	ETQ_86	
		FLD 	@aux81	
		FSTP	_auxFiltro	
		JMP	ETQ_101	
ETQ_86
		FLD 	_d	
		FSTP	@aux86	
		FLD 	@aux70	
		FCOMP	@aux86	
		FSTSW	AX	
		SAHF		
		JB	ETQ_91	
		FLD 	@aux86	
		FSTP	_auxFiltro	
		JMP	ETQ_101	
ETQ_91
		FLD 	_f	
		FSTP	@aux91	
		FLD 	@aux70	
		FCOMP	@aux91	
		FSTSW	AX	
		SAHF		
		JB	ETQ_96	
		FLD 	@aux91	
		FSTP	_auxFiltro	
		JMP	ETQ_101	
ETQ_96
		FLD 	_g	
		FSTP	@aux96	
		FLD 	@aux70	
		FCOMP	@aux96	
		FSTSW	AX	
		SAHF		
		JB	ETQ_101	
		FLD 	@aux96	
		FSTP	_auxFiltro	
		JMP	ETQ_101	
ETQ_101
		FLD 	_a	
		FSTP	@aux101	
		FCOMP	@aux101	
		FSTSW	AX	
		SAHF		
		JNE	ETQ_REPEAT65	
		FLD 	_a	
		FSTP	@aux106	
		FLD 	_b	
		FSTP	@aux107	
		FLD 	@aux106	
		FCOMP	@aux107	
		FSTSW	AX	
		SAHF		
		JB	ETQ_REPEAT64	
		FLD 	_a	
		FSTP	@aux110	
		FLD 	_6_00	
		FSTP	@aux111	
		FLD 	@aux110	
		FCOMP	@aux111	
		FSTSW	AX	
		SAHF		
		JE	ETQ_116	
		displayString	__"1"	
		newLine		
		JMP	ETQ_117	
ETQ_116
		displayString	__"2"	
		newLine		
ETQ_117
		FLD 	_j	
		FSTP	@aux117	
		FLD 	_r	
		FSTP	@aux118	
		FLD 	@aux117	
		FCOMP	@aux118	
		FSTSW	AX	
		SAHF		
		JE	ETQ_135	
		displayString	__"3"	
		newLine		
		FLD 	_123_00	
		FSTP	@aux122	
		FLD 	_asd	
		FSTP	@aux123	
		FLD 	@aux122	
		FCOMP	@aux123	
		FSTSW	AX	
		SAHF		
		JA	ETQ_128	
		displayString	__"4"	
		newLine		
		JMP	ETQ_134	
ETQ_128
		FLD 	_t	
		FSTP	@aux128	
		FLD 	_3_00	
		FSTP	@aux129	
		FLD 	@aux128	
		FCOMP	@aux129	
		FSTSW	AX	
		SAHF		
		JAE	ETQ_134	
		displayString	__"5"	
		newLine		
		displayString	__"5b"	
		newLine		
ETQ_134
		JMP	ETQ_136	
ETQ_135
		displayString	__"4"	
		newLine		
mov ah,4ch
mov al,0
int 21h

STRLEN PROC NEAR
	mov BX,0

STRL01:
	cmp BYTE PTR [SI+BX],'$'
	je STREND
	inc BX
	jmp STRL01

STREND:
	ret

STRLEN ENDP

COPIAR PROC NEAR
	call STRLEN
	cmp BX,MAXTEXTSIZE
	jle COPIARSIZEOK
	mov BX,MAXTEXTSIZE

COPIARSIZEOK:
	mov CX,BX
	cld
	rep movsb
	mov al,'$'
	mov BYTE PTR [DI],al
	ret

COPIAR ENDP

END START
>>>>>>> Stashed changes
