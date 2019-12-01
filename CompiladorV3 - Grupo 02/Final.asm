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
	___OK_	db	"OK", "$"
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

.CODE
START:
; ******* CODIGO PERMANENTE ********
		mov AX,@DATA
		mov DS,AX
		mov es,ax
; **********************************
ETQ_0:
		FLD	_f1	
		FSTP	@aux0	
ETQ_1:
		FLD	_f2	
		FSTP	@aux1	
ETQ_2:
		FLD	@aux0	
		FCOMP	@aux1	
		FSTSW	ax	
		SAHF		
ETQ_3:
		JNA	ETQ_11	
ETQ_4:
		JNBE	ETQ_10	
ETQ_5:
		FLD	_f3	
		FSTP	@aux5	
ETQ_6:
		FLD	_f4	
		FSTP	@aux6	
ETQ_7:
		FLD	@aux5	
		FCOMP	@aux6	
		FSTSW	ax	
		SAHF		
ETQ_8:
		JNB	ETQ_11	
ETQ_9:
		JNAE	ETQ_10	
ETQ_10:
		displayString	___OK_	
		newLine		
ETQ_11:
		mov ax, 4C00h
		int 21h
END START