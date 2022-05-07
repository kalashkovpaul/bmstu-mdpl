; Ввод: 
; знаковое в 2 с/с
; Вывод: 
; беззнаковое в 8 с/с
; знаковое в 16 с/с
EXTRN read_bin_sign: near
EXTRN print_bin_sign: near
EXTRN print_oct_unsign: near
EXTRN print_hex: near


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
    err db "Error$"

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
    MOV dx, offset err
    MOV ah, 9
    int 21h
    MOV dl, 13
    MOV ah, 2
    int 21H
    MOV dl, 10 
    int 21h
    jmp main
SEGCODE ENDS
END main