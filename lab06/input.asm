PUBLIC read_bin_sign

PUBLIC UNSIGNEDOCT
PUBLIC SIGNEDHEX
PUBLIC HEXTABLE
PUBLIC VALUE

SEGDATA SEGMENT PARA PUBLIC 'DATA'
    VALUE DW 0
    MAXLEN DB 17
    CURLEN DB 0
    STRING DB 17 dup ("$")
    UNSIGNEDOCT DB 5 dup (0), "$"
    SIGNEDHEX DB 4 dup (0), "$"

    HEXTABLE DB "0123456789ABCDEF$"

    msg_in db "Enter binary digit with sign(max 16 digits): $"
    wrong_input db "Wrong input. If without + and -, then 16 digits only$"
    oneZeroMessage db "Only 1 and 0!$"
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA

read_bin_sign proc near
start:
    MOV VALUE, 0
    MOV ah, 9
    MOV dx, offset msg_in
    int 21h

    MOV DX, offset MAXLEN
    MOV AH, 0Ah
    int 21H
    MOV    ah, 2
    MOV    dl, 13
    int    21H
    MOV    dl, 10
    int    21H

    CMP STRING, "-"
    JNE ifNotMinus
checkIfMinus:
    CMP STRING, "-"
    JE setMinus
    CMP STRING, "1"
    JE setMinus
transformToNumber:
    CMP STRING, "-"
    JE setFirstIndex
    CMP STRING, "+"
    JE setFirstIndex
transform:
    MOV CX, 0
    MOV CL, CURLEN
    SUB CX, 1

    MOV SI, 1
    ADD DI, 1
transformIteration:
    MOV BX, 0
    MOV BL, [STRING + SI]

    CMP BX, '0'
    JB oneZeroError
    CMP BX, '1'
    JA oneZeroError

    CMP BX, "0"
    JNE setOne
transformIterationEnd:
    ADD SI, 1
    ADD DI, 1
    LOOP transformIteration

    MOV AX, VALUE
    AND AX, 1000000000000000B
    CMP AX, 1000000000000000B
    JE toExtended
inputEnd:
    RET

ifNotMinus:
    CMP STRING, "+"
    JNE ifNotMinusNotPlus
    JMP transformToNumber
ifNotMinusNotPlus:
    CMP CURLEN, 16
    JNE printWrongMessage
    JMP checkIfMinus
printWrongMessage:
    MOV ah, 9
    MOV dx, offset wrong_input
    int 21h

    MOV    ah, 2
    MOV    dl, 13
    int    21H
    MOV    dl, 10
    int    21H
    jmp start
setMinus:
    MOV AX, 0
    OR AX, 1000000000000000B
    MOV VALUE, AX
    JMP transformToNumber
setFirstIndex:
    MOV CX, 16
    MOV DI, CX
    MOV CX, 0
    MOV CL, CURLEN
    SUB DI, CX
    JMP transform
oneZeroError:
    MOV ah, 9
    MOV dx, offset oneZeroMessage   
    int 21h

    MOV ah, 2
    MOV dl, 13
    int 21H
    MOV dl, 10
    int 21H
    jmp start
setOne:
    MOV AX, 1000000000000000B
    MOV BX, CX
    MOV CX, 0
    MOV CX, DI
    RCR AX, CL
    MOV CX, BX
    OR VALUE, AX
    JMP transformIterationEnd
toExtended:
    NOT VALUE
    ADD VALUE, 1
    MOV AX, 1000000000000000B
    OR VALUE, AX
    JMP inputEnd

read_bin_sign ENDP


SEGCODE ENDS
END

; +1111 1111 1111
; 3