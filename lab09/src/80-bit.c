#include "process.h"

#ifndef X87

long double sum_80(long double a, long double b) {
    return a + b;
}

long double mul_80(long double a, long double b) {
    return a * b;
}

long double asm_sum_80(long double a, long double b) {
    long double res = 0;
    __asm__
    (   
        ".intel_syntax noprefix\n\t"
        "fld qword ptr 16[rbp]\n\t"
        "fld qword ptr 32[rbp]\n\t"
        "faddp\n\t"
        "fstp qword ptr -16[rbp]\n\t"
    );
    return res;
}

long double asm_mul_80(long double a, long double b) {
    long double res = 0;
    __asm__(".intel_syntax noprefix\n\t"
            "fld qword ptr 16[rbp]\n\t"
            "fld qword ptr 32[rbp]\n\t"
            "fmulp\n\t"
            "fstp qword ptr -32[rbp]\n\t"
    );
    return res;
}

void print_80() {
    long double a = 10e+12;
    long double b = 10e-12;

    printf("Time for %d trying:\n\n", COUNT);
    puts("C: ");
    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++)
        sum_80(a, b);
    clock_t end_sum = (clock() - beg_sum);
    printf("Sum %.3Lg s\n", (long double) end_sum / CLOCKS_PER_SEC / (long double) COUNT);


    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++)
        mul_80(a, b);
    clock_t end_mul = (clock() - beg_mul);
    printf("Mul %.3Lg s\n", (long double) end_mul / CLOCKS_PER_SEC / (long double) COUNT);

}

void asm_print_80() {
    puts("Assembler: ");
    long double a = 10e+12;
    long double b = 10e-12;

    clock_t beg_sum = clock();
    for (int i = 0; i < COUNT; i++)
        asm_sum_80(a, b);
    clock_t end_sum = (clock() - beg_sum);
    printf("Sum %.3Lg s\n", (long double) end_sum / CLOCKS_PER_SEC / (long double) COUNT);

    clock_t beg_mul = clock();
    for (int i = 0; i < COUNT; i++)
        asm_mul_80(a, b);
    clock_t end_mul = (clock() - beg_mul);
    printf("Mul %.3Lg s\n", (long double) end_mul / CLOCKS_PER_SEC / (long double) COUNT);
}
#endif