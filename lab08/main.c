#include "stdio.h"

void my_strcpy(char *dst, char *src, int len);
int my_strlen(const char *str)
{
    long int len;
    // AT&T
    asm
    (
        "movl %%edi, %%ebx\n\t" // %%, потому что AT&T
        "inc %%ebx\n\t"
        "xor %%al, %%al\n\t"
        /* Команда SCASB (SCAn String Byte) сравнивает регистр AL с байтом в ячейке памяти по адресу ES:DI 
        и устанавливает флаги аналогично команде CMP. После выполнения команды, 
        регистр DI увеличивается на 1, если флаг DF = 0, или уменьшается на 1, если DF = 1. */
        "repne scasb\n\t\t"
        "sub %%ebx, %%edi\n\t"
        :"=D"(len) // выход, "=" означает, что операнд для данной инструкции предназначен только для записи.
        :"D"(str) // вход, D = Регистры edi, rdi и их версии
        :"al", "ebx" //Регистры, изменяемые вставкой
    );
    return len;
}

int main()
{
    int len;
    char before[32] = {'0'}, *middle = before + 2, *after = middle + 2;
    char messg[] = "This is my test for strcpy";

    len = my_strlen(messg);
    printf("String length = %d\n", len);
    
    my_strcpy(middle, messg, len);
    printf("Copy: %s\n", middle);

    my_strcpy(before, middle, len);
    printf("Copy before: %s\n", before);

    my_strcpy(after, before, len);
    printf("Copy after: %s\n", after);

    my_strcpy(after, after, len);
    printf("Identical: %s\n", after);

    return 0;
}

