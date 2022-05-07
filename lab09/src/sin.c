#include <math.h>
#include "process.h"

#define PI 3.14
#define PI_LONG 3.141596

void compare_sin() {
    printf("sin(3.14) and sin(3.141596)\n");
    printf("PI = %f| %g\n", PI, sin(PI));
    printf("PI = %f| %g\n", PI_LONG, sin(PI_LONG));

    printf("FPU\n");
    double res = 0;
    __asm__(".intel_syntax noprefix\n\t"
            "fldpi\n\t"
            "fsin\n\t"
            "fstp %0\n\t"
    :"=m"(res));
    printf("PI = %f| %g\n\n\n", PI, res);


    printf("sin(3.14 / 2) and sin(3.141596 / 2)\n");
    printf("PI = %f| %g\n", PI / 2, sin(PI / (double)2));
    printf("PI = %f| %g\n", PI_LONG / 2, sin(PI_LONG / (double)2.0));
    printf("FPU\n");
    res = 1.0;
    __asm__(".intel_syntax noprefix\n\t"
            "fldpi\n\t"
            "fld1\n\t"
            "fld1\n\t"
            "faddp\n\t"
            "fdivp\n\t"
            "fsin\n\t"
            "fstp %0\n\t"
    :"=m"(res));
    printf("PI/2 = %f| %g\n", PI / 2.0, res);
}