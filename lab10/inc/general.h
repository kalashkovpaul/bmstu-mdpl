#ifndef LAB_10_GENERAL_H
#define LAB_10_GENERAL_H

#include <stdio.h>

typedef struct 
{
    float buf[4];
} vector_t;

void c_scalar_prod(float *dst, const vector_t *src_a, const vector_t *src_b);
void sse_scalar_prod(float *dst, const vector_t *src_a, const vector_t *src_b);
#endif