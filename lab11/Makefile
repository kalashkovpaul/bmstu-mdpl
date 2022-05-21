# Компилятор
CC := gcc

# Опции компилятора
CFLAGS := -no-pie $(shell pkg-config --cflags --libs gtk+-3.0)

# Ассемблер
AS := nasm

# Опции ассемблера
ASFLAGS := -felf64

# Фиктивные цели
.PHONY: clean

out/calculator: out/main.o
	$(CC) -o $@ $^ $(CFLAGS) 

out/main.o: main.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) out/*