CC := gcc
CFLAGS := -std=c99 -Wall -Werror
AC := nasm
AFLAGS := -felf64

app.exe: my_strcpy.o main.o
	gcc -o app.exe $^
	gcc -S main.c

my_strcpy.o: my_strcpy.asm
	$(AC) $(AFLAGS) $< -o $@

main.o: main.c
	$(CC) $(CGLAGS) -c $<

clean:
	-rm *.o *.exe *.s
	@ls