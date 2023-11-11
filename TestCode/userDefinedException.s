	.file	"userDefinedException.c"
	.intel_syntax noprefix
 # GNU C17 (Rev10, Built by MSYS2 project) version 12.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.2.0, MPC version 1.3.1, isl version isl-0.25-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -masm=intel -mtune=generic -march=nocona -O0
	.text
	.globl	userDefinedException
	.def	userDefinedException;	.scl	2;	.type	32;	.endef
	.seh_proc	userDefinedException
userDefinedException:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	.seh_endprologue
 # TestCode\userDefinedException.c:5:     return;
	nop	
 # TestCode\userDefinedException.c:6: }
	pop	rbp	 #
	ret	
	.seh_endproc
	.globl	fib1
	.def	fib1;	.scl	2;	.type	32;	.endef
	.seh_proc	fib1
fib1:
	push	rbp	 #
	.seh_pushreg	rbp
	push	rbx	 #
	.seh_pushreg	rbx
	sub	rsp, 40	 #,
	.seh_stackalloc	40
	lea	rbp, 32[rsp]	 #,
	.seh_setframe	rbp, 32
	.seh_endprologue
	mov	DWORD PTR 32[rbp], ecx	 # a, a
 # TestCode\userDefinedException.c:11:     if (a <= 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jg	.L4	 #,
 # TestCode\userDefinedException.c:13:         return 0;
	mov	eax, 0	 # _5,
	jmp	.L5	 #
.L4:
 # TestCode\userDefinedException.c:15:     else if (a == 1)
	cmp	DWORD PTR 32[rbp], 1	 # a,
	jne	.L6	 #,
 # TestCode\userDefinedException.c:17:         return 1;
	mov	eax, 1	 # _5,
	jmp	.L5	 #
.L6:
 # TestCode\userDefinedException.c:21:         return fib1(a - 1) + fib1(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp88, a
	sub	eax, 1	 # _1,
	mov	ecx, eax	 #, _1
	call	fib1	 #
	mov	ebx, eax	 # _2,
 # TestCode\userDefinedException.c:21:         return fib1(a - 1) + fib1(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp89, a
	sub	eax, 2	 # _3,
	mov	ecx, eax	 #, _3
	call	fib1	 #
 # TestCode\userDefinedException.c:21:         return fib1(a - 1) + fib1(a - 2);
	add	eax, ebx	 # _5, _2
.L5:
 # TestCode\userDefinedException.c:23: }
	add	rsp, 40	 #,
	pop	rbx	 #
	pop	rbp	 #
	ret	
	.seh_endproc
	.globl	fib2
	.def	fib2;	.scl	2;	.type	32;	.endef
	.seh_proc	fib2
fib2:
	push	rbp	 #
	.seh_pushreg	rbp
	push	rbx	 #
	.seh_pushreg	rbx
	sub	rsp, 40	 #,
	.seh_stackalloc	40
	lea	rbp, 32[rsp]	 #,
	.seh_setframe	rbp, 32
	.seh_endprologue
	mov	DWORD PTR 32[rbp], ecx	 # a, a
 # TestCode\userDefinedException.c:27:     if (a <= 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jg	.L8	 #,
 # TestCode\userDefinedException.c:29:         if (a < 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jns	.L9	 #,
 # TestCode\userDefinedException.c:31:             userDefinedException();
	call	userDefinedException	 #
.L9:
 # TestCode\userDefinedException.c:33:         return 0;
	mov	eax, 0	 # _5,
	jmp	.L10	 #
.L8:
 # TestCode\userDefinedException.c:35:     else if (a == 1)
	cmp	DWORD PTR 32[rbp], 1	 # a,
	jne	.L11	 #,
 # TestCode\userDefinedException.c:37:         return 1;
	mov	eax, 1	 # _5,
	jmp	.L10	 #
.L11:
 # TestCode\userDefinedException.c:41:         return fib2(a - 1) + fib2(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp88, a
	sub	eax, 1	 # _1,
	mov	ecx, eax	 #, _1
	call	fib2	 #
	mov	ebx, eax	 # _2,
 # TestCode\userDefinedException.c:41:         return fib2(a - 1) + fib2(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp89, a
	sub	eax, 2	 # _3,
	mov	ecx, eax	 #, _3
	call	fib2	 #
 # TestCode\userDefinedException.c:41:         return fib2(a - 1) + fib2(a - 2);
	add	eax, ebx	 # _5, _2
.L10:
 # TestCode\userDefinedException.c:43: }
	add	rsp, 40	 #,
	pop	rbx	 #
	pop	rbp	 #
	ret	
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "TestCode\\userDefinedException.c\0"
.LC1:
	.ascii "a >= 0\0"
	.text
	.globl	fib3
	.def	fib3;	.scl	2;	.type	32;	.endef
	.seh_proc	fib3
fib3:
	push	rbp	 #
	.seh_pushreg	rbp
	push	rbx	 #
	.seh_pushreg	rbx
	sub	rsp, 40	 #,
	.seh_stackalloc	40
	lea	rbp, 32[rsp]	 #,
	.seh_setframe	rbp, 32
	.seh_endprologue
	mov	DWORD PTR 32[rbp], ecx	 # a, a
 # TestCode\userDefinedException.c:47:     assert(a >= 0);
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jns	.L15	 #,
 # TestCode\userDefinedException.c:47:     assert(a >= 0);
	mov	r8d, 47	 #,
	lea	rax, .LC0[rip]	 # tmp90,
	mov	rdx, rax	 #, tmp90
	lea	rax, .LC1[rip]	 # tmp91,
	mov	rcx, rax	 #, tmp91
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp92,
	call	rax	 # tmp92
.L15:
 # TestCode\userDefinedException.c:48:     if (a <= 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jg	.L16	 #,
 # TestCode\userDefinedException.c:50:         if (a < 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jns	.L17	 #,
 # TestCode\userDefinedException.c:52:             userDefinedException();
	call	userDefinedException	 #
.L17:
 # TestCode\userDefinedException.c:54:         return 0;
	mov	eax, 0	 # _5,
	jmp	.L18	 #
.L16:
 # TestCode\userDefinedException.c:56:     else if (a == 1)
	cmp	DWORD PTR 32[rbp], 1	 # a,
	jne	.L19	 #,
 # TestCode\userDefinedException.c:58:         return 1;
	mov	eax, 1	 # _5,
	jmp	.L18	 #
.L19:
 # TestCode\userDefinedException.c:62:         return fib3(a - 1) + fib3(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp93, a
	sub	eax, 1	 # _1,
	mov	ecx, eax	 #, _1
	call	fib3	 #
	mov	ebx, eax	 # _2,
 # TestCode\userDefinedException.c:62:         return fib3(a - 1) + fib3(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp94, a
	sub	eax, 2	 # _3,
	mov	ecx, eax	 #, _3
	call	fib3	 #
 # TestCode\userDefinedException.c:62:         return fib3(a - 1) + fib3(a - 2);
	add	eax, ebx	 # _5, _2
.L18:
 # TestCode\userDefinedException.c:64: }
	add	rsp, 40	 #,
	pop	rbx	 #
	pop	rbp	 #
	ret	
	.seh_endproc
	.ident	"GCC: (Rev10, Built by MSYS2 project) 12.2.0"
