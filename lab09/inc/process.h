#ifndef PROCESS_H_

#define PROCESS_H_

#include <stdio.h>
#include <time.h>

#define COUNT 10000

/* 32bit - float */
float sum_32(float a, float b);
float mul_32(float a, float b);

float asm_sum_32(float a, float b);
float asm_mul_32(float a, float b);

void print_32();
void asm_print_32();

/* 64bit - double */
double sum_64(double a, double b);
double mul_64(double a, double b);

double asm_sum_64(double a, double b);
double asm_mul_64(double a, double b);

void print_64();
void asm_print_64();

#ifndef X87
/* 80bit - long double */
long double sum_80(long double a, long double b);
long double mul_80(long double a, long double b);

long double asm_sum_80(long double a, long double b);
long double asm_mul_80(long double a, long double b);

void print_80();
void asm_print_80();
#endif

void compare_sin();

#endif