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
		FSTP	@aux12	
ETQ_13:
		FLD	__10_00	
		FSTP	@aux13	
ETQ_14:
		FLD	@aux12	
		FCOMP	@aux13	
		FSTSW	ax	
		SAHF		
ETQ_15:
		JNA	ETQ_9	
ETQ_16:
		GetFloat	_i2	
ETQ_17:
		FLD	_i2	
		FSTP	@aux17	
ETQ_18:
		FLD	__15_00	
		FSTP	@aux18	
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