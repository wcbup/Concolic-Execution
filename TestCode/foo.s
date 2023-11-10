	.file	"foo.c"
	.intel_syntax noprefix
 # GNU C17 (Rev10, Built by MSYS2 project) version 12.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.2.0, MPC version 1.3.1, isl version isl-0.25-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -masm=intel -mtune=generic -march=nocona -O0
	.text
	.globl	sum
	.def	sum;	.scl	2;	.type	32;	.endef
	.seh_proc	sum
sum:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # a, a
	mov	DWORD PTR 24[rbp], edx	 # b, b
	mov	DWORD PTR 32[rbp], r8d	 # c, c
	mov	DWORD PTR 40[rbp], r9d	 # d, d
 # TestCode\foo.c:3:     return a + b + c + d + e + f + g;
	mov	edx, DWORD PTR 16[rbp]	 # tmp89, a
	mov	eax, DWORD PTR 24[rbp]	 # tmp90, b
	add	edx, eax	 # _1, tmp90
 # TestCode\foo.c:3:     return a + b + c + d + e + f + g;
	mov	eax, DWORD PTR 32[rbp]	 # tmp91, c
	add	edx, eax	 # _2, tmp91
 # TestCode\foo.c:3:     return a + b + c + d + e + f + g;
	mov	eax, DWORD PTR 40[rbp]	 # tmp92, d
	add	edx, eax	 # _3, tmp92
 # TestCode\foo.c:3:     return a + b + c + d + e + f + g;
	mov	eax, DWORD PTR 48[rbp]	 # tmp93, e
	add	edx, eax	 # _4, tmp93
 # TestCode\foo.c:3:     return a + b + c + d + e + f + g;
	mov	eax, DWORD PTR 56[rbp]	 # tmp94, f
	add	edx, eax	 # _5, tmp94
 # TestCode\foo.c:3:     return a + b + c + d + e + f + g;
	mov	eax, DWORD PTR 64[rbp]	 # tmp95, g
	add	eax, edx	 # _13, _5
 # TestCode\foo.c:4: }
	pop	rbp	 #
	ret	
	.seh_endproc
	.ident	"GCC: (Rev10, Built by MSYS2 project) 12.2.0"
