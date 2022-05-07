	.file	"main.c"
	.text
	.globl	my_strlen
	.type	my_strlen, @function
my_strlen:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, -32(%rbp)
	movq	-32(%rbp), %rdx
	movq	%rdx, %rdi
#APP
# 8 "main.c" 1
	movl %edi, %ebx
	inc %ebx
	xor %al, %al
	repne scasb
		sub %ebx, %edi
	
# 0 "" 2
#NO_APP
	movq	%rdi, %rdx
	movq	%rdx, -16(%rbp)
	movq	-16(%rbp), %rax
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	my_strlen, .-my_strlen
	.section	.rodata
.LC0:
	.string	"String length = %d\n"
.LC1:
	.string	"Copy: %s\n"
.LC2:
	.string	"Copy before: %s\n"
.LC3:
	.string	"Copy after: %s\n"
.LC4:
	.string	"Identical: %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$48, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	leaq	-48(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -88(%rbp)
	movabsq	$2338328219631577172, %rax
	movabsq	$2338620986089306477, %rdx
	movq	%rax, -80(%rbp)
	movq	%rdx, -72(%rbp)
	movabsq	$7165917994914312038, %rax
	movq	%rax, -64(%rbp)
	movw	$31088, -56(%rbp)
	movb	$0, -54(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	my_strlen
	movl	%eax, -100(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-100(%rbp), %edx
	leaq	-80(%rbp), %rcx
	movq	-96(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	my_strcpy@PLT
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-100(%rbp), %edx
	movq	-96(%rbp), %rcx
	leaq	-48(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	my_strcpy@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-100(%rbp), %edx
	leaq	-48(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	my_strcpy@PLT
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-100(%rbp), %edx
	movq	-88(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	my_strcpy@PLT
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
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
