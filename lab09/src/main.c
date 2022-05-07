#include <stdio.h>
#include "process.h"

int main() {
    printf("Float (32-bit): ");
    print_32();
    asm_print_32();
    printf("\n");
    printf("Double (64-bit): ");
    print_64();
    asm_print_64();
    printf("\n");

#ifndef X87
    printf("Long double (80-bit): ");
    print_80();
    asm_print_80();
    printf("\n");
#endif
    compare_sin();
}