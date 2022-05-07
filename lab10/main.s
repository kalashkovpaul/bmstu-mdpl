	.file	"main.c"
	.text
	.section	.rodata
.LC0:
	.string	"[%lf %lf %lf] "
.LC1:
	.string	""
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movss	8(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm2
	movq	-8(%rbp), %rax
	movss	4(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm1
	movq	-8(%rbp), %rax
	movss	(%rax), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC0(%rip), %rdi
	movl	$3, %eax
	call	printf@PLT
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.section	.rodata
.LC6:
	.string	"C:"
.LC8:
	.string	"result = %f\ntime = %.3g s\n"
.LC9:
	.string	"Assembler: "
	.text
	.globl	test
	.type	test, @function
test:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -120(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movss	.LC2(%rip), %xmm0
	movss	%xmm0, -100(%rbp)
	movss	.LC3(%rip), %xmm0
	movss	%xmm0, -96(%rbp)
	movss	.LC4(%rip), %xmm0
	movss	%xmm0, -92(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -108(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -104(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movss	-100(%rbp), %xmm0
	movss	%xmm0, -48(%rbp)
	movss	-96(%rbp), %xmm0
	movss	%xmm0, -44(%rbp)
	movss	-92(%rbp), %xmm0
	movss	%xmm0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movss	-100(%rbp), %xmm0
	movss	%xmm0, -32(%rbp)
	movss	-96(%rbp), %xmm0
	movss	%xmm0, -28(%rbp)
	movss	-92(%rbp), %xmm0
	movss	%xmm0, -24(%rbp)
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	call	clock@PLT
	movq	%rax, -72(%rbp)
	movq	$0, -88(%rbp)
	jmp	.L3
.L4:
	leaq	-32(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-108(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	c_scalar_prod@PLT
	addq	$1, -88(%rbp)
.L3:
	movq	-88(%rbp), %rax
	cmpq	-120(%rbp), %rax
	jb	.L4
	call	clock@PLT
	subq	-72(%rbp), %rax
	movq	%rax, -64(%rbp)
	cvtsi2sdq	-64(%rbp), %xmm0
	movsd	.LC7(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	movq	-120(%rbp), %rax
	testq	%rax, %rax
	js	.L5
	cvtsi2sdq	%rax, %xmm0
	jmp	.L6
.L5:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L6:
	divsd	%xmm0, %xmm1
	movss	-108(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC8(%rip), %rdi
	movl	$2, %eax
	call	printf@PLT
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	call	clock@PLT
	movq	%rax, -72(%rbp)
	movq	$0, -80(%rbp)
	jmp	.L7
.L8:
	leaq	-32(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	leaq	-104(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	sse_scalar_prod@PLT
	addq	$1, -80(%rbp)
.L7:
	movq	-80(%rbp), %rax
	cmpq	-120(%rbp), %rax
	jb	.L8
	call	clock@PLT
	subq	-72(%rbp), %rax
	movq	%rax, -56(%rbp)
	cvtsi2sdq	-56(%rbp), %xmm0
	movsd	.LC7(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	movq	-120(%rbp), %rax
	testq	%rax, %rax
	js	.L9
	cvtsi2sdq	%rax, %xmm0
	jmp	.L10
.L9:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L10:
	divsd	%xmm0, %xmm1
	movss	-104(%rbp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	leaq	.LC8(%rip), %rdi
	movl	$2, %eax
	call	printf@PLT
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	test, .-test
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$10000, %edi
	call	test
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC2:
	.long	1092616192
	.align 4
.LC3:
	.long	1101004800
	.align 4
.LC4:
	.long	1106247680
	.align 8
.LC7:
	.long	0
	.long	1093567616
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
