PUBLIC newline
PUBLIC print_space
PUBLIC print_matrix
PUBLIC calc_index

EXTRN n: byte
EXTRN m: byte
EXTRN matrix: byte

SEGDATA SEGMENT PARA COMMON 'DATA'
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA

calc_index proc near
    mul bl
    MOV di, ax
    ret
calc_index endp

newline proc near
    MOV ah, 2
    MOV dl, 10
    int 21H
    MOV dl, 13
    int 21H

    ret
newline endp

print_space proc near
    MOV ah, 2
    MOV dl, " "
    int 21H

    ret
print_space endp


print_matrix proc near
    ; в si пишу количество символов
    MOV al, m
    mul n
    MOV CX, AX
    MOV si, 0
    MOV di, 0
    print:
        MOV ah, 2
        MOV dl, matrix[si]
        add dl, '0'
        int 21H

        call print_space

        inc si
        inc di
        ; проверка на перевод на новую строку
        MOV AX, si
        MOV bl, m
        div bl
        cmp ah, 0
        ; je newline
        je call_newline_print
        go_back_out:

        loop print
    ret
    call_newline_print:
        call calc_index
        call newline
        jmp go_back_out

print_matrix endp



SEGCODE ENDS
END