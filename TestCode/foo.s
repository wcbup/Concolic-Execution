	.file	"foo.c"
	.intel_syntax noprefix
 # GNU C17 (Rev10, Built by MSYS2 project) version 12.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.2.0, MPC version 1.3.1, isl version isl-0.25-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -masm=intel -mtune=generic -march=nocona -O0
	.text
	.globl	foo
	.def	foo;	.scl	2;	.type	32;	.endef
	.seh_proc	foo
foo:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 16	 #,
	.seh_stackalloc	16
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # a, a
 # TestCode\foo.c:10:     b = 2;
	mov	DWORD PTR -4[rbp], 2	 # b,
 # TestCode\foo.c:11:     c = 3;
	mov	DWORD PTR -8[rbp], 3	 # c,
 # TestCode\foo.c:12:     c *= 7;
	mov	edx, DWORD PTR -8[rbp]	 # tmp87, c
	mov	eax, edx	 # tmp88, tmp87
	sal	eax, 3	 # tmp89,
	sub	eax, edx	 # tmp90, tmp87
	mov	DWORD PTR -8[rbp], eax	 # c, tmp90
 # TestCode\foo.c:13:     b = a + 1;
	mov	eax, DWORD PTR 16[rbp]	 # tmp94, a
	add	eax, 1	 # tmp93,
	mov	DWORD PTR -4[rbp], eax	 # b, tmp93
 # TestCode\foo.c:14:     c = (a - 2) / b * 77;
	mov	eax, DWORD PTR 16[rbp]	 # tmp95, a
	sub	eax, 2	 # _1,
 # TestCode\foo.c:14:     c = (a - 2) / b * 77;
	cdq
	idiv	DWORD PTR -4[rbp]	 # b
 # TestCode\foo.c:14:     c = (a - 2) / b * 77;
	imul	eax, eax, 77	 # tmp98, _2,
	mov	DWORD PTR -8[rbp], eax	 # c, tmp98
 # TestCode\foo.c:16:     return a + b + c;
	mov	edx, DWORD PTR 16[rbp]	 # tmp99, a
	mov	eax, DWORD PTR -4[rbp]	 # tmp100, b
	add	edx, eax	 # _3, tmp100
 # TestCode\foo.c:16:     return a + b + c;
	mov	eax, DWORD PTR -8[rbp]	 # tmp101, c
	add	eax, edx	 # _10, _3
 # TestCode\foo.c:17: }
	add	rsp, 16	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.ident	"GCC: (Rev10, Built by MSYS2 project) 12.2.0"
