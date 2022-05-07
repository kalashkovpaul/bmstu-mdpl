#include "process.h"

float sum_32(float a, float b) {
    return a + b;
}

float mul_32(float a, float b) {
    return a * b;
}

float asm_sum_32(float a, float b) {
    float res = 0;
    __asm__(".intel_syntax noprefix\n\t"    // Intel, а не AT&T
            "fld %1\n\t"                    // загрузить а
            "fld %2\n\t"                    // загрузить b
            "faddp\n\t"                     // сложить
            "fstp %0\n\t"                   // Сохранить вещественное значение с извлечением из стека
            : "=&m"(res)
            : "m"(a),"m"(b)
            );
    return res;
}

float asm_mul_32(float a, float b) {
    float res = 0;
    __asm__(".intel_syntax noprefix\n\t"
            "fld %1\n\t"
            "fld %2\n\t"
            "fmulp\n\t"
            "fstp %0\n\t"
    : "=&m"(res)
    : "m"(a),"m"(b)
    );
    return res;

}

void print_32() {
    float a = 10e+12;
    float b = 10e-12;


    printf("Time for %d trying:\n\n", COUNT);
    puts("C: ");
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++)
        sum_32(a, b);
    clock_t end_sum = (clock() - beg_sum);
    printf("Sum %.3g s\n", (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++)
        mul_32(a, b);
    clock_t end_mul = (clock() - beg_mul);
    printf("Mul  %.3g s\n", (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);

}

void asm_print_32() {
    puts("Assembler: ");
    float a = 10e+3;
    float b = 10e-3;

    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++)
        asm_sum_32(a, b);
    clock_t end_sum = (clock() - beg_sum);
    printf("Sum %.3g s\n", (double) end_sum / CLOCKS_PER_SEC / (double) COUNT);

    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++)
        asm_mul_32(a, b);
    clock_t end_mul = (clock() - beg_mul);
    printf("Mul %.3g s\n", (double) end_mul / CLOCKS_PER_SEC / (double) COUNT);
}