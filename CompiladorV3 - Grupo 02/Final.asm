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
	___1_	db	"1", "$"
	___2_	db	"2", "$"
	___3_	db	"3", "$"
	___4_	db	"4", "$"
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
		FLD	_f3	
		FSTP	@aux4	
ETQ_5:
		FLD	_f4	
		FSTP	@aux5	
ETQ_6:
		FLD	@aux4	
		FCOMP	@aux5	
		FSTSW	ax	
		SAHF		
ETQ_7:
		JNB	ETQ_11	
ETQ_8:
		displayString	___1_	
		newLine		
ETQ_9:
		displayString	___2_	
		newLine		
ETQ_10:
		JMP	ETQ_13	
ETQ_11:
		displayString	___3_	
		newLine		
ETQ_12:
		displayString	___4_	
		newLine		
ETQ_13:
		mov ax, 4C00h
		int 21h
END START