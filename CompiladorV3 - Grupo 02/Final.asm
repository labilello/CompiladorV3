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
	___F1__	db	"F1 ", "$"
	___F2__	db	"F2 ", "$"
	___IGUALES_	db	"IGUALES", "$"
	___F1_MENOR_	db	"F1 MENOR", "$"
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

.CODE
START:
; ******* CODIGO PERMANENTE ********
		mov AX,@DATA
		mov DS,AX
		mov es,ax
; **********************************
ETQ_1:
		displayString	___F1__	
		newLine		
ETQ_2:
		GetFloat	_f1	
ETQ_3:
		displayString	___F2__	
		newLine		
ETQ_4:
		GetFloat	_f2	
ETQ_5:
		FLD	_f1	
		FSTP	@aux5	
ETQ_6:
		FLD	_f2	
		FSTP	@aux6	
ETQ_7:
		FLD	@aux5	
		FCOMP	@aux6	
		FSTSW	ax	
		SAHF		
ETQ_8:
		JNAE	ETQ_15	
ETQ_9:
		FLD	_f1	
		FSTP	@aux9	
ETQ_10:
		FLD	_f2	
		FSTP	@aux10	
ETQ_11:
		FLD	@aux9	
		FCOMP	@aux10	
		FSTSW	ax	
		SAHF		
ETQ_12:
		JNE	ETQ_14	
ETQ_13:
		displayString	___IGUALES_	
		newLine		
ETQ_14:
		JMP	ETQ_16	
ETQ_15:
		displayString	___F1_MENOR_	
		newLine		
ETQ_16:
		mov ax, 4C00h
		int 21h
END START