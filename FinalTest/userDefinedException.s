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
 # FinalTest\userDefinedException.c:5:     return;
	nop	
 # FinalTest\userDefinedException.c:6: }
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
 # FinalTest\userDefinedException.c:10:     if (a <= 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jg	.L4	 #,
 # FinalTest\userDefinedException.c:12:         return 0;
	mov	eax, 0	 # _5,
	jmp	.L5	 #
.L4:
 # FinalTest\userDefinedException.c:14:     else if (a == 1)
	cmp	DWORD PTR 32[rbp], 1	 # a,
	jne	.L6	 #,
 # FinalTest\userDefinedException.c:16:         return 1;
	mov	eax, 1	 # _5,
	jmp	.L5	 #
.L6:
 # FinalTest\userDefinedException.c:20:         return fib1(a - 1) + fib1(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp88, a
	sub	eax, 1	 # _1,
	mov	ecx, eax	 #, _1
	call	fib1	 #
	mov	ebx, eax	 # _2,
 # FinalTest\userDefinedException.c:20:         return fib1(a - 1) + fib1(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp89, a
	sub	eax, 2	 # _3,
	mov	ecx, eax	 #, _3
	call	fib1	 #
 # FinalTest\userDefinedException.c:20:         return fib1(a - 1) + fib1(a - 2);
	add	eax, ebx	 # _5, _2
.L5:
 # FinalTest\userDefinedException.c:22: }
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
 # FinalTest\userDefinedException.c:26:     if (a <= 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jg	.L8	 #,
 # FinalTest\userDefinedException.c:28:         if (a < 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jns	.L9	 #,
 # FinalTest\userDefinedException.c:30:             userDefinedException();
	call	userDefinedException	 #
.L9:
 # FinalTest\userDefinedException.c:32:         return 0;
	mov	eax, 0	 # _5,
	jmp	.L10	 #
.L8:
 # FinalTest\userDefinedException.c:34:     else if (a == 1)
	cmp	DWORD PTR 32[rbp], 1	 # a,
	jne	.L11	 #,
 # FinalTest\userDefinedException.c:36:         return 1;
	mov	eax, 1	 # _5,
	jmp	.L10	 #
.L11:
 # FinalTest\userDefinedException.c:40:         return fib2(a - 1) + fib2(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp88, a
	sub	eax, 1	 # _1,
	mov	ecx, eax	 #, _1
	call	fib2	 #
	mov	ebx, eax	 # _2,
 # FinalTest\userDefinedException.c:40:         return fib2(a - 1) + fib2(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp89, a
	sub	eax, 2	 # _3,
	mov	ecx, eax	 #, _3
	call	fib2	 #
 # FinalTest\userDefinedException.c:40:         return fib2(a - 1) + fib2(a - 2);
	add	eax, ebx	 # _5, _2
.L10:
 # FinalTest\userDefinedException.c:42: }
	add	rsp, 40	 #,
	pop	rbx	 #
	pop	rbp	 #
	ret	
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "FinalTest\\userDefinedException.c\0"
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
 # FinalTest\userDefinedException.c:46:     assert(a >= 0);
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jns	.L15	 #,
 # FinalTest\userDefinedException.c:46:     assert(a >= 0);
	mov	r8d, 46	 #,
	lea	rax, .LC0[rip]	 # tmp90,
	mov	rdx, rax	 #, tmp90
	lea	rax, .LC1[rip]	 # tmp91,
	mov	rcx, rax	 #, tmp91
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp92,
	call	rax	 # tmp92
.L15:
 # FinalTest\userDefinedException.c:47:     if (a <= 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jg	.L16	 #,
 # FinalTest\userDefinedException.c:49:         if (a < 0)
	cmp	DWORD PTR 32[rbp], 0	 # a,
	jns	.L17	 #,
 # FinalTest\userDefinedException.c:51:             userDefinedException();
	call	userDefinedException	 #
.L17:
 # FinalTest\userDefinedException.c:53:         return 0;
	mov	eax, 0	 # _5,
	jmp	.L18	 #
.L16:
 # FinalTest\userDefinedException.c:55:     else if (a == 1)
	cmp	DWORD PTR 32[rbp], 1	 # a,
	jne	.L19	 #,
 # FinalTest\userDefinedException.c:57:         return 1;
	mov	eax, 1	 # _5,
	jmp	.L18	 #
.L19:
 # FinalTest\userDefinedException.c:61:         if (a > 100)
	cmp	DWORD PTR 32[rbp], 100	 # a,
	jle	.L20	 #,
 # FinalTest\userDefinedException.c:63:             userDefinedException();
	call	userDefinedException	 #
.L20:
 # FinalTest\userDefinedException.c:65:         return fib3(a - 1) + fib3(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp93, a
	sub	eax, 1	 # _1,
	mov	ecx, eax	 #, _1
	call	fib3	 #
	mov	ebx, eax	 # _2,
 # FinalTest\userDefinedException.c:65:         return fib3(a - 1) + fib3(a - 2);
	mov	eax, DWORD PTR 32[rbp]	 # tmp94, a
	sub	eax, 2	 # _3,
	mov	ecx, eax	 #, _3
	call	fib3	 #
 # FinalTest\userDefinedException.c:65:         return fib3(a - 1) + fib3(a - 2);
	add	eax, ebx	 # _5, _2
.L18:
 # FinalTest\userDefinedException.c:67: }
	add	rsp, 40	 #,
	pop	rbx	 #
	pop	rbp	 #
	ret	
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "a > b\0"
.LC3:
	.ascii "c > 0\0"
	.text
	.globl	user1
	.def	user1;	.scl	2;	.type	32;	.endef
	.seh_proc	user1
user1:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 32	 #,
	.seh_stackalloc	32
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # a, a
	mov	DWORD PTR 24[rbp], edx	 # b, b
	mov	DWORD PTR 32[rbp], r8d	 # c, c
 # FinalTest\userDefinedException.c:71:     assert(a > b);
	mov	eax, DWORD PTR 16[rbp]	 # tmp88, a
	cmp	eax, DWORD PTR 24[rbp]	 # tmp88, b
	jg	.L24	 #,
 # FinalTest\userDefinedException.c:71:     assert(a > b);
	mov	r8d, 71	 #,
	lea	rax, .LC0[rip]	 # tmp89,
	mov	rdx, rax	 #, tmp89
	lea	rax, .LC2[rip]	 # tmp90,
	mov	rcx, rax	 #, tmp90
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp91,
	call	rax	 # tmp91
.L24:
 # FinalTest\userDefinedException.c:72:     assert(c > 0);
	cmp	DWORD PTR 32[rbp], 0	 # c,
	jg	.L27	 #,
 # FinalTest\userDefinedException.c:72:     assert(c > 0);
	mov	r8d, 72	 #,
	lea	rax, .LC0[rip]	 # tmp92,
	mov	rdx, rax	 #, tmp92
	lea	rax, .LC3[rip]	 # tmp93,
	mov	rcx, rax	 #, tmp93
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp94,
	call	rax	 # tmp94
.L27:
 # FinalTest\userDefinedException.c:73:     if (a - c > b)
	mov	eax, DWORD PTR 16[rbp]	 # tmp95, a
	sub	eax, DWORD PTR 32[rbp]	 # _1, c
 # FinalTest\userDefinedException.c:73:     if (a - c > b)
	cmp	DWORD PTR 24[rbp], eax	 # b, _1
	jge	.L28	 #,
 # FinalTest\userDefinedException.c:75:         userDefinedException();
	call	userDefinedException	 #
.L28:
 # FinalTest\userDefinedException.c:77: }
	nop	
	add	rsp, 32	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.section .rdata,"dr"
.LC4:
	.ascii "a < b\0"
.LC5:
	.ascii "c >= 0\0"
	.text
	.globl	user2
	.def	user2;	.scl	2;	.type	32;	.endef
	.seh_proc	user2
user2:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 32	 #,
	.seh_stackalloc	32
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # a, a
	mov	DWORD PTR 24[rbp], edx	 # b, b
	mov	DWORD PTR 32[rbp], r8d	 # c, c
 # FinalTest\userDefinedException.c:81:     assert(a < b);
	mov	eax, DWORD PTR 16[rbp]	 # tmp90, a
	cmp	eax, DWORD PTR 24[rbp]	 # tmp90, b
	jl	.L32	 #,
 # FinalTest\userDefinedException.c:81:     assert(a < b);
	mov	r8d, 81	 #,
	lea	rax, .LC0[rip]	 # tmp91,
	mov	rdx, rax	 #, tmp91
	lea	rax, .LC4[rip]	 # tmp92,
	mov	rcx, rax	 #, tmp92
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp93,
	call	rax	 # tmp93
.L32:
 # FinalTest\userDefinedException.c:82:     assert(c >= 0);
	cmp	DWORD PTR 32[rbp], 0	 # c,
	jns	.L35	 #,
 # FinalTest\userDefinedException.c:82:     assert(c >= 0);
	mov	r8d, 82	 #,
	lea	rax, .LC0[rip]	 # tmp94,
	mov	rdx, rax	 #, tmp94
	lea	rax, .LC5[rip]	 # tmp95,
	mov	rcx, rax	 #, tmp95
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp96,
	call	rax	 # tmp96
.L35:
 # FinalTest\userDefinedException.c:83:     a -= b + c * b + 1;
	mov	eax, DWORD PTR 32[rbp]	 # tmp97, c
	imul	eax, DWORD PTR 24[rbp]	 # tmp97, b
	mov	edx, eax	 # _1, tmp97
 # FinalTest\userDefinedException.c:83:     a -= b + c * b + 1;
	mov	eax, DWORD PTR 24[rbp]	 # tmp98, b
	add	eax, edx	 # _2, _1
 # FinalTest\userDefinedException.c:83:     a -= b + c * b + 1;
	add	eax, 1	 # _3,
 # FinalTest\userDefinedException.c:83:     a -= b + c * b + 1;
	sub	DWORD PTR 16[rbp], eax	 # a, _3
 # FinalTest\userDefinedException.c:84:     if (a > b)
	mov	eax, DWORD PTR 16[rbp]	 # tmp99, a
	cmp	eax, DWORD PTR 24[rbp]	 # tmp99, b
	jle	.L36	 #,
 # FinalTest\userDefinedException.c:86:         userDefinedException();
	call	userDefinedException	 #
.L36:
 # FinalTest\userDefinedException.c:88: }
	nop	
	add	rsp, 32	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.ident	"GCC: (Rev10, Built by MSYS2 project) 12.2.0"
