	.file	"scalar.c"
	.text
	.globl	c_scalar_prod
	.type	c_scalar_prod, @function
c_scalar_prod:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rax
	movss	(%rax), %xmm1
	movq	-24(%rbp), %rax
	movss	(%rax), %xmm0
	mulss	%xmm0, %xmm1
	movq	-16(%rbp), %rax
	movss	4(%rax), %xmm2
	movq	-24(%rbp), %rax
	movss	4(%rax), %xmm0
	mulss	%xmm2, %xmm0
	addss	%xmm0, %xmm1
	movq	-16(%rbp), %rax
	movss	8(%rax), %xmm2
	movq	-24(%rbp), %rax
	movss	8(%rax), %xmm0
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movq	-8(%rbp), %rax
	movss	%xmm0, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	c_scalar_prod, .-c_scalar_prod
	.globl	sse_scalar_prod
	.type	sse_scalar_prod, @function
sse_scalar_prod:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rcx
#APP
# 14 "src/scalar.c" 1
	.intel_syntax noprefix
	movaps xmm0, (%rdx)
	movaps xmm1, (%rcx)
	mulps xmm0, xmm1
	movhlps xmm1, xmm0
	addps xmm0, xmm1
	movaps xmm1, xmm0
	shufps xmm0, xmm0, 1
	addps xmm0, xmm1
	movss (%rax), xmm0
	
# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	sse_scalar_prod, .-sse_scalar_prod
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
