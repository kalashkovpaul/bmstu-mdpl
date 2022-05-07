; чётные элементы увеличить на 1, нечётные -
; уменьшить на 1. Вывести только последние цифры
; новых значений

EXTRN newline: near
EXTRN print_space: near
EXTRN print_matrix: near
EXTRN calc_index: near

PUBLIC m
PUBLIC n
PUBLIC matrix

STK SEGMENT PARA STACK 'STACK'
    DB 200 dup (0)
STK ENDS
SEGDATA SEGMENT PARA COMMON 'DATA'
    m   db 1;
    n   db 1;
    matrix  db 81 dup('0')

    in_rows_msg db "Input count of rows([1:9]) $"
    in_cols_msg db "Input count of cols([1:9]) $"
    result_msg db "Result matrix $"
    err db "Error$"
SEGDATA ENDS

SEGCODE SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:SEGCODE, DS:SEGDATA, SS:STK

main:
    MOV AX, SEGDATA

    ; кол-во строк
    MOV DS, AX

    MOV dx, offset in_rows_msg
    MOV ah, 9
    int 21h
    ; считывание n
    MOV ah, 1
    int 21H
    ; MOV al, 33h
    MOV n, al
    ; проверка валидности n
    cmp al, '0'
    jbe exit_err
    cmp al, '9'
    jnbe exit_err

    sub n, '0'

    ; новая строка
    call newline

    ; сообщение считывания m 
    MOV dx, offset in_cols_msg
    MOV ah, 9
    int 21h

    MOV ah, 1
    int 21H
    ; MOV al, 33h
    MOV m, al

    cmp al, '0'
    ; проверки валидности
    jbe exit_err
    cmp al, '9'
    ja exit_err

    sub m, '0'

    ; вывод новой строки
    call newline

    MOV al, m
    mul n
    MOV CX, AX ; CX -  количество элементов в матрице
    MOV si, 0
    MOV di, 0
    read_matrix:
        MOV ah, 1
        int 21H
        ; MOV al, 31h
        cmp al, '0'
        jb exit_err
        cmp al, '9'
        ja exit_err
        sub al, '0'
        MOV matrix[di], al
        inc si
        inc di
        call print_space

        ; проверка на перевод на новую строку
        MOV AX, si
        MOV bl, m
        div bl  
        cmp ah, 0
        je call_newline
        je calc_index
        go_back:

        loop read_matrix
    
    call newline

    MOV al, m
    mul n
    MOV cx, AX
    MOV si, 0
    MOV BP, 0
    new_matrix:
        xor AX, AX
        xor bx, bx
        MOV bl, matrix[BP]
        MOV ax, bx
        MOV bl, 2
        div bl
        cmp ah, 0
        je incr
        jne decr
        go_next:
        inc BP
        loop new_matrix


    MOV dx, offset result_msg
    MOV ah, 9
    int 21h
    call newline

    call print_matrix
    
    exit:
    MOV ax, 4c00H
    int 21H

exit_err:
    MOV dl, 10
    MOV ah, 2
    int 21H
    MOV dl, 13 
    int 21h
    MOV dx, offset err
    MOV ah, 9
    int 21h
    jmp exit

call_newline:
    call newline
    jmp go_back

decr:
    dec matrix[BP]
    jmp go_next
incr:
    inc matrix[BP]
    jmp go_next

SEGCODE ENDS
END main
