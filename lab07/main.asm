; Написать резидентную программу под DOS, которая будет каждую секунду менять
; скорость автоповтора ввода символов в циклическом режиме, от самой медленной до
; самой быстрой.
.MODEL TINY
.CODE
.186
ORG 100H


main:
    JMP INIT
    OLD_INTERRUPTION DD ?
    SPEED DB 01FH 
    COUNT DB 0

INIT proc     

    MOV AH, 35H
    MOV AL, 1CH
    INT 21H

    MOV WORD PTR OLD_INTERRUPTION, BX
    MOV WORD PTR OLD_INTERRUPTION + 2, ES
                      
    MOV AH, 25H
    MOV AL, 1CH
    MOV DX, OFFSET INTERRUPTION
    INT 21H                             

    MOV DX, OFFSET INIT
    INT 27H

INIT endp

INTERRUPTION proc
    PUSH DX
    PUSH AX

    INC COUNT
    CMP COUNT, 12H
    JNE END_LOOP
    MOV COUNT, 0
    DEC SPEED

    MOV AL, 0F3H
    OUT 60H, AL
    MOV AL, SPEED
    OUT 60H, AL

    TEST SPEED, 01FH
    JZ RESET_SPEED
    JMP END_LOOP

    RESET_SPEED:
        MOV SPEED, 01FH

    END_LOOP:
        POP AX
        POP DX
        JMP CS:OLD_INTERRUPTION
INTERRUPTION endp

end main