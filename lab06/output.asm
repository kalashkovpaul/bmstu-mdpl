public print_bin_sign
public print_oct_unsign
public print_hex

EXTRN VALUE:WORD
EXTRN UNSIGNEDOCT: BYTE
EXTRN SIGNEDHEX: BYTE

EXTRN to_oct:near
EXTRN to_hex:near

SEGDATA SEGMENT PARA PUBLIC 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE

print_oct_unsign proc near
    MOV BX, VALUE
    MOV CX, 1000000000000000B
    AND CX, BX
    CMP CX, 1000000000000000B
    JE printOne
    JNE printZero
mainOctPart:
    CALL TO_OCT

    MOV AH, 9
    MOV DX, OFFSET UNSIGNEDOCT
    INT 21h

    MOV AH, 2
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21H
    RET
printOne:
    MOV AH, 2
    MOV DL, "1"
    INT 21H
    JMP mainOctPart
printZero:
    MOV AH, 2
    MOV DL, "0"
    INT 21H
    JMP mainOctPart
print_oct_unsign endp

print_hex proc near
    MOV BX, VALUE
    MOV CX, 1000000000000000B
    AND CX, BX
    CMP CX, 1000000000000000B
    JE printHexMinus
    JNE printHexPlus
mainHexPart:
    CALL TO_HEX
    MOV AH, 9
    MOV DX, OFFSET SIGNEDHEX
    INT 21H
    MOV AH, 2
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21H
    RET
printHexMinus:
    MOV AH, 2
    MOV DL, "-"
    INT 21H
    MOV BX, VALUE
    SUB BX, 1
    NOT BX
    MOV AX, 1000000000000000B
    OR BX, AX
    JMP mainHexPart
printHexPlus:
    MOV AH, 2
    MOV DL, "+"
    INT 21H
    JMP mainHexPart
print_hex endp

print_bin_sign proc near 
    MOV BX, VALUE
    MOV CX, 1000000000000000B
    AND CX, BX
    CMP CX, 1000000000000000B
    JE printMinus
    JNE printPlus


mainPart:
    MOV AH, 2

    MOV DX, 0100000000000000B
    AND DX, BX
    MOV CL, 14
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0010000000000000B
    AND DX, BX
    MOV CL, 13
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0001000000000000B
    AND DX, BX
    MOV CL, 12
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000100000000000B
    AND DX, BX
    MOV CL, 11
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000010000000000B
    AND DX, BX
    MOV CL, 10
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000001000000000B
    AND DX, BX
    MOV CL, 9
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000100000000B
    AND DX, BX
    MOV CL, 8
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000010000000B
    AND DX, BX
    MOV CL, 7
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000001000000B
    AND DX, BX
    MOV CL, 6
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000000100000B
    AND DX, BX
    MOV CL, 5
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000000010000B
    AND DX, BX
    MOV CL, 4
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000000001000B
    AND DX, BX
    MOV CL, 3
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000000000100B
    AND DX, BX
    MOV CL, 2
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000000000010B
    AND DX, BX
    MOV CL, 1
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    MOV DX, 0000000000000001B
    AND DX, BX
    MOV CL, 0
    SHR DX, CL
    ADD DX, '0'
    INT 21H
    
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21H
    RET

printMinus:
    MOV AH, 2
    MOV DL, "-"
    INT 21H
    MOV BX, VALUE
    SUB BX, 1
    NOT BX
    MOV AX, 1000000000000000B
    OR BX, AX
    JMP mainPart
printPlus:
    MOV AH, 2
    MOV DL, "+"
    MOV BX, VALUE
    INT 21H
    JMP mainPart
print_bin_sign endp

SEGCODE ENDS
END