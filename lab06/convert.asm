PUBLIC to_oct
PUBLIC to_hex

EXTRN VALUE:WORD
EXTRN HEXTABLE:BYTE

EXTRN UNSIGNEDOCT:BYTE
EXTRN SIGNEDHEX:BYTE


SEGDATA SEGMENT PUBLIC 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PUBLIC 'CODE'
    ASSUME CS:SEGCODE

to_oct proc near
    MOV CX, 5
    MOV DI, 0
    MOV SI, 12
iteration:
    MOV AX, VALUE
    XCHG CX, SI
    SHR AX, CL
    XCHG CX, SI
    AND AL, 7
    ADD AX, "0"
    MOV UNSIGNEDOCT[DI], AL
    INC DI
    SUB SI, 3
    LOOP iteration
    RET
to_oct endp

to_hex proc near

mainHexConvert:
    MOV DX, BX
    MOV BX, OFFSET HEXTABLE
    MOV CL, 12
    MOV AX, DX
    SHR AX, CL
    AND AL, 00000111B
    XLAT ; СМЕЩЕНИЕ ДЛЯ HEXTABLE БЕРЁТСЯ ИЗ AL И КОНВЕРТИРУЕТСЯ AL->HEXTABLE[AL]
    MOV SIGNEDHEX[0], AL
    MOV CL, 8
    MOV AX, DX
    SHR AX, CL
    AND AL, 00001111B
    XLAT
    MOV SIGNEDHEX[1], AL
    MOV CL, 4
    MOV AX, DX
    SHR AX, CL
    AND AL, 00001111B
    XLAT
    MOV SIGNEDHEX[2], AL
    MOV AX, DX
    AND AL, 00001111B
    XLAT
    MOV SIGNEDHEX[3], AL
    RET

to_hex endp


SEGCODE ENDS
END