GLOBAL my_strcpy

SECTION .text
my_strcpy:
    MOV RCX, RDX  ;_strcopy(RDI, RSI, RDX)
    INC RCX

    CMP RDI, RSI ; src == dst ? quit : not_equal()
    JNE not_equal
    JMP quit

not_equal: ; смотрим, перекрываются ли строки
    CMP RDI, RSI ; RDI <= RSI == dst string < src string
    JLE simple_copy

complicated_copy: ; строки перекрываются
    ADD RDI, RCX ; смещаемся на длину и копируем с конца
    ADD RSI, RCX
    DEC RSI
    DEC RDI
    STD ; df = 1

simple_copy:
    REP MOVSB ; from rsi to rdi while df==0  len == rcx раз
    CLD ; df = 0
quit:
    RET