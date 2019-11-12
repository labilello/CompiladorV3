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
	__6_00	dd	6.00
	___1_	db	"1", "$"
	___2_	db	"2", "$"
	___3_	db	"3", "$"
	__123_00	dd	123.00
	___4_	db	"4", "$"
	___5_	db	"5", "$"
	___5b_	db	"5b", "$"
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
	@aux21	dd	?
	@aux22	dd	?
	@aux23	dd	?
	@aux24	dd	?
	@aux25	dd	?
	@aux26	dd	?
	@aux27	dd	?
	@aux28	dd	?
	@aux29	dd	?
	@aux30	dd	?
	@aux31	dd	?
	@aux32	dd	?
	@aux33	dd	?
	@aux34	dd	?
	@aux35	dd	?
	@aux36	dd	?
	@aux37	dd	?
	@aux38	dd	?
	@aux39	dd	?
	@aux40	dd	?
	@aux41	dd	?
	@aux42	dd	?
	@aux43	dd	?
	@aux44	dd	?
	@aux45	dd	?
	@aux46	dd	?
	@aux47	dd	?
	@aux48	dd	?
	@aux49	dd	?
	@aux50	dd	?
	@aux51	dd	?
	@aux52	dd	?
	@aux53	dd	?
	@aux54	dd	?
	@aux55	dd	?
	@aux56	dd	?
	@aux57	dd	?
	@aux58	dd	?
	@aux59	dd	?
	@aux60	dd	?
	@aux61	dd	?
	@aux62	dd	?
	@aux63	dd	?
	@aux64	dd	?
	@aux65	dd	?
	@aux66	dd	?
	@aux67	dd	?
	@aux68	dd	?
	@aux69	dd	?
	@aux70	dd	?
	@aux71	dd	?
	@aux72	dd	?
	@aux73	dd	?
	@aux74	dd	?
	@aux75	dd	?
	@aux76	dd	?
	@aux77	dd	?
	@aux78	dd	?
	@aux79	dd	?
	@aux80	dd	?
	@aux81	dd	?
	@aux82	dd	?
	@aux83	dd	?
	@aux84	dd	?
	@aux85	dd	?
	@aux86	dd	?
	@aux87	dd	?
	@aux88	dd	?
	@aux89	dd	?
	@aux90	dd	?
	@aux91	dd	?
	@aux92	dd	?
	@aux93	dd	?
	@aux94	dd	?
	@aux95	dd	?
	@aux96	dd	?

.CODE
START:
; ******* CODIGO PERMANENTE ********
		mov AX,@DATA
		mov DS,AX
		mov es,ax
; **********************************
ETQ_REPEAT_64
ETQ_3:
		FLD	_a	
		FSTP	_aa	
ETQ_4:
		FLD	__2147483_00	
		FSTP	_d	
ETQ_6:
		FLD	_constante1	
		FSTP	_h2	
ETQ_7:
		FLD	__0_50	
		FSTP	_p4	
ETQ_8:
		FLD	_a	
		FSTP	@aux8	
ETQ_9:
		FLD	_b	
		FSTP	@aux9	
ETQ_10:
		FLD	_p1	
		FSTP	@aux10	
ETQ_11:
		FLD	__5_00	
		FSTP	@aux11	
ETQ_12:
		FLD 		
		FMUL		
		FSTP	@aux12	
ETQ_13:
		FLD 		
		FADD	@aux12	
		FSTP	@aux13	
ETQ_14:
		FLD 		
		FCOMP	@aux13	
		FSTSW	AX	
		SAHF		
ETQ_15:
		JNB	ETQ_17	
ETQ_16:
		FLD	_constante1	
		FSTP	_aa	
ETQ_17
ETQ_17:
		FLD	_a	
		FSTP	@aux17	
ETQ_18:
		FLD	__25_00	
		FSTP	@aux18	
ETQ_19:
		FLD	_h1	
		FSTP	@aux19	
ETQ_20:
		FLD 		
		FMUL		
		FSTP	@aux20	
ETQ_21:
		FLD 		
		FADD	@aux20	
		FSTP	@aux21	
ETQ_22:
		FLD	__3_00	
		FSTP	@aux22	
ETQ_23:
		FLD 	@aux21	
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_24:
		JNA	ETQ_26	
ETQ_25:
		FLD	_constante1	
		FSTP	_aa	
ETQ_26
ETQ_26:
		FLD	__3_00	
		FSTP	@aux26	
ETQ_27:
		FLD	_b	
		FSTP	@aux27	
ETQ_28:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_29:
ETQ_30:
		FLD	_constante1	
		FSTP	_h2	
ETQ_31:
		FLD	__3_00	
		FSTP	@aux31	
ETQ_32:
		FLD	_b	
		FSTP	@aux32	
ETQ_33:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_34:
		JNAE	ETQ_36	
ETQ_35:
		FLD	_constante1	
		FSTP	_h2	
ETQ_36
ETQ_36:
		FLD	__3_00	
		FSTP	@aux36	
ETQ_37:
		FLD	_b	
		FSTP	@aux37	
ETQ_38:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_39:
		FLD	_a	
		FSTP	@aux39	
ETQ_40:
		FLD	_b	
		FSTP	@aux40	
ETQ_41:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_42:
ETQ_43:
		JZ	ETQ_45	
ETQ_44:
		FLD	_constante1	
		FSTP	_h2	
ETQ_45
ETQ_45:
		FLD	_b	
		FSTP	@aux45	
ETQ_46:
		FLD	__5_00	
		FSTP	@aux46	
ETQ_47:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_48:
		FLD	__5_00	
		FSTP	@aux48	
ETQ_49:
		FLD	_	
		FSTP	@aux49	
ETQ_50:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_51:
ETQ_52:
		JZ	ETQ_59	
ETQ_53:
		FLD	__52_00	
		FSTP	_b	
ETQ_54:
		FLD	_	
		FSTP	@aux54	
ETQ_55:
		FLD	_	
		FSTP	@aux55	
ETQ_56:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_57:
		JNAE	ETQ_59	
ETQ_58:
		FLD	__125_00	
		FSTP	_b	
ETQ_59
ETQ_59:
		FLD	__3_00	
		FSTP	@aux59	
ETQ_60:
		FLD	_b	
		FSTP	@aux60	
ETQ_61:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_62:
ETQ_63:
		FLD	_constante1	
		FSTP	_h2	
ETQ_REPEAT_64
ETQ_64:
ETQ_65:
		FLD	__3_00	
		FSTP	_b	
ETQ_66:
		FLD	__5_00	
		FSTP	_b	
ETQ_67:
		FLD	_a	
		FSTP	@aux67	
ETQ_68:
		FLD	_b	
		FSTP	@aux68	
ETQ_69:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_70:
		JNB	ETQ_REPEAT64	
ETQ_71:
		FLD	_a	
		FSTP	@aux71	
ETQ_72:
		FLD	__6_00	
		FSTP	@aux72	
ETQ_73:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_74:
		JNE	ETQ_77	
ETQ_75:
		displayString	___1_	
		newLine		
ETQ_76:
		JMP	ETQ_78	
ETQ_77
ETQ_77:
		displayString	___2_	
		newLine		
ETQ_78
ETQ_78:
		FLD	_	
		FSTP	@aux78	
ETQ_79:
		FLD	_	
		FSTP	@aux79	
ETQ_80:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_81:
		JNE	ETQ_96	
ETQ_82:
		displayString	___3_	
		newLine		
ETQ_83:
		FLD	__123_00	
		FSTP	@aux83	
ETQ_84:
		FLD	_	
		FSTP	@aux84	
ETQ_85:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_86:
		JNA	ETQ_89	
ETQ_87:
		displayString	___4_	
		newLine		
ETQ_88:
		JMP	ETQ_95	
ETQ_89
ETQ_89:
		FLD	_	
		FSTP	@aux89	
ETQ_90:
		FLD	__3_00	
		FSTP	@aux90	
ETQ_91:
		FLD 		
		FCOMP		
		FSTSW	AX	
		SAHF		
ETQ_92:
		JNAE	ETQ_95	
ETQ_93:
		displayString	___5_	
		newLine		
ETQ_94:
		displayString	___5b_	
		newLine		
ETQ_95
ETQ_95:
		JMP	ETQ_97	
ETQ_96
ETQ_96:
		displayString	___4_	
		newLine		
ETQ_97:
		mov ax, 4C00h
		int 21h
END START