; Ввод: 
; знаковое в 2 с/с
; Вывод: 
; беззнаковое в 8 с/с
; знаковое в 16 с/с


STK SEGMENT PARA STACK 'STACK'
	    DB 200 dup (0)
STK ENDS

SEGDATA SEGMENT PARA PUBLIC 'DATA'
	menu_print DB "1. Input sign num in binary format"
	           DB 10
	           DB 13
	           DB "2. Output num in binary format"
	           DB 10
	           DB 13
	           DB "3. Output num in unsigned oct format"
	           DB 10
	           DB 13
	           DB "4. Output num in signed hex format"
	           DB 10
	           DB 13
	           DB "5. Exit"
	           DB 10
	           DB 13
	           DB "Enter mode: $"
	actions    DW read_bin_sign, print_bin_sign, print_oct_unsign, print_hex, exit
    message_error db "Error$"
    VALUE DW 0
    MAXLEN DB 18
    CURLEN DB 0
    STRING DB 18 dup ("$")
    UNSIGNEDOCT DB 5 dup (0), "$"
    SIGNEDHEX DB 4 dup (0), "$"

    HEXTABLE DB "0123456789ABCDEF$"

    msg_in db "Enter binary digit with sign(max 16 digits): $"
    wrong_input db "Wrong input. If without + and -, then 16 digits only$"
    oneZeroMessage db "Only 1 and 0!$"

SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC "CODE"
	        ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK
    
	main:   
		MOV    AX, SEGDATA
		MOV    DS, AX
		menu:   
			MOV    ah, 9
			MOV    dx, offset menu_print
			int    21h
			MOV    ah, 1
			int    21h

			MOV    ah, 0
            cmp    al, '0'
            jb     printError
            cmp    al, '9'
            ja     printError
			sub    al, "1"
			MOV    dl, 2
			mul    dl
			MOV    bx, ax
			
			MOV    ah, 2
			MOV    dl, 13
			int    21H
			MOV    dl, 10
			int    21H

			call   actions[bx]
			jmp    menu
	exit:
	        MOV    ax, 4c00h
	        int    21h
printError:
    MOV dl, 13
    MOV ah, 2
    int 21H
    MOV dl, 10 
    int 21h
    MOV dx, offset message_error
    MOV ah, 9
    int 21h
    MOV dl, 13
    MOV ah, 2
    int 21H
    MOV dl, 10 
    int 21h
    jmp main
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
setFirstIndex:
    CMP CURLEN, 17
    JE checkIfMax
    MOV CX, 16
    MOV DI, CX
    MOV CX, 0
    MOV CL, CURLEN
    SUB DI, CX
    JMP transform
ifNotMinus:
    CMP STRING, "+"
    JNE ifNotMinusNotPlus
    JMP transformToNumber
ifNotMinusNotPlus:
    CMP CURLEN, 16
    JNE printWrongMessage
    JMP checkIfMinus
setMinus:
    MOV AX, 0
    OR AX, 1000000000000000B
    MOV VALUE, AX
    JMP transformToNumber
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

checkIfMax:
    CMP STRING, "-"
    JNE printWrongMessage
    CMP [STRING + 1], "1"
    JNE printWrongMessage
    MOV CX, 15
    MOV DI, 2
checkIfMaxIteration:
    CMP [STRING + DI], "0"
    JNE printWrongMessage
    INC DI
    LOOP checkIfMaxIteration
    
    MOV AX, 1000000000000000B
    MOV VALUE, AX
    JMP inputEnd
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

read_bin_sign ENDP

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

printMaxHex:
    MOV AH, 2
    MOV DL, "-"
    INT 21H
    MOV DL, "8"
    INT 21H
    MOV DL, "0"
    INT 21H
    INT 21H
    INT 21H
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21H
    RET

print_hex proc near
    CMP VALUE, 1000000000000000B
    JE printMaxHex
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

printMaxBin:
    MOV AH, 2
    MOV DL, "-"
    INT 21H
    MOV DL, "1"
    INT 21H
    JMP invert

print_bin_sign proc near 
    CMP VALUE, 1000000000000000B
    JE printMaxBin
    MOV BX, VALUE
    MOV CX, 1000000000000000B
    AND CX, BX
    CMP CX, 1000000000000000B
    JE printMinus
    JNE printPlus
printMinus:
    MOV AH, 2
    MOV DL, "-"
    INT 21H
invert:
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
print_bin_sign endp
    
SEGCODE ENDS
END main