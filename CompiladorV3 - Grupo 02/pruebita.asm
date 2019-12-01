include macros2.asm
include number.asm

.MODEL LARGE
.STACK 200h

.386
MAXTEXTSIZE equ 50

.DATA
    _f1 dd  ?
    _f2 dd  ?
    _f3 dq  ?
    _f4 dd  ?
    _f5 dd  ?
    _f6 dd  ?
    _f7 dd  ?
    _i1 dd  ?
    _i2 dd  ?
    _i3 dd  ?
    _i4 dd  ?
    _i5 dd  ?
    _i6 dd  ?
    _i7 dd  ?
    ___OK_  db  "OK", "$"
    ___NO_OK_   db  "NO OK", "$"
    _auxFiltro  dd  ?
    @aux0   dd  ?
    @aux1   dd  ?
    @aux2   dd  ?
    @aux3   dd  ?
    @aux4   dd  ?
    @aux5   dd  ?
    @aux6   dd  ?

.CODE
START:
; ******* CODIGO PERMANENTE ********
        mov AX,@DATA
        mov DS,AX
        mov es,ax
; **********************************
ETQ_0:
        FLD _f1 
        FSTP    @aux0   
ETQ_1:
        FLD _f2 
        FSTP    @aux1   
ETQ_2:
        FLD @aux0   
        FCOMP   @aux1   
        FSTSW   _f3
        SAHF        
        displayString   _f3
        newLine 
ETQ_3:
        mov ax, 4C00h
        int 21h
END START