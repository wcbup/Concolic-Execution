	.file	"array.c"
	.intel_syntax noprefix
 # GNU C17 (Rev10, Built by MSYS2 project) version 12.2.0 (x86_64-w64-mingw32)
 #	compiled by GNU C version 12.2.0, GMP version 6.2.1, MPFR version 4.2.0, MPC version 1.3.1, isl version isl-0.25-GMP

 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed: -masm=intel -mtune=generic -march=nocona -O0
	.text
	.globl	array1
	.def	array1;	.scl	2;	.type	32;	.endef
	.seh_proc	array1
array1:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 16	 #,
	.seh_stackalloc	16
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # i, i
 # TestCode\array.c:4:     int a[] = {0, 1, 9};
	mov	DWORD PTR -12[rbp], 0	 # a[0],
	mov	DWORD PTR -8[rbp], 1	 # a[1],
	mov	DWORD PTR -4[rbp], 9	 # a[2],
 # TestCode\array.c:5:     return a[i];
	mov	eax, DWORD PTR 16[rbp]	 # tmp85, i
	cdqe
	mov	eax, DWORD PTR -12[rbp+rax*4]	 # _6, a[i_5(D)]
 # TestCode\array.c:6: }
	add	rsp, 16	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.globl	array2
	.def	array2;	.scl	2;	.type	32;	.endef
	.seh_proc	array2
array2:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 32	 #,
	.seh_stackalloc	32
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # i, i
 # TestCode\array.c:10:     int a[] = {0, 1, 2};
	mov	DWORD PTR -20[rbp], 0	 # a[0],
	mov	DWORD PTR -16[rbp], 1	 # a[1],
	mov	DWORD PTR -12[rbp], 2	 # a[2],
 # TestCode\array.c:11:     int b = 3, c = 4;
	mov	DWORD PTR -4[rbp], 3	 # b,
 # TestCode\array.c:11:     int b = 3, c = 4;
	mov	DWORD PTR -8[rbp], 4	 # c,
 # TestCode\array.c:12:     if (i <= 5 && i >= 0)
	cmp	DWORD PTR 16[rbp], 5	 # i,
	jg	.L4	 #,
 # TestCode\array.c:12:     if (i <= 5 && i >= 0)
	cmp	DWORD PTR 16[rbp], 0	 # i,
	js	.L4	 #,
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	mov	eax, DWORD PTR 16[rbp]	 # tmp92, i
	cdqe
	mov	edx, DWORD PTR -20[rbp+rax*4]	 # _1, a[i_15(D)]
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	mov	eax, DWORD PTR 16[rbp]	 # tmp93, i
	add	eax, 1	 # _2,
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	cdqe
	mov	eax, DWORD PTR -20[rbp+rax*4]	 # _3, a[_2]
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	lea	ecx, 1[rax]	 # _4,
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	mov	eax, DWORD PTR 16[rbp]	 # tmp95, i
	add	eax, 2	 # _5,
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	cdqe
	mov	eax, DWORD PTR -20[rbp+rax*4]	 # _6, a[_5]
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	imul	eax, ecx	 # _7, _4
 # TestCode\array.c:14:         return a[i] + (a[i + 1] + 1) * a[i + 2];
	add	eax, edx	 # _8, _1
	jmp	.L6	 #
.L4:
 # TestCode\array.c:18:         return 0;
	mov	eax, 0	 # _8,
.L6:
 # TestCode\array.c:20: }
	add	rsp, 32	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.globl	array3
	.def	array3;	.scl	2;	.type	32;	.endef
	.seh_proc	array3
array3:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 32	 #,
	.seh_stackalloc	32
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # i, i
 # TestCode\array.c:25:     a[4] = 100;
	mov	DWORD PTR -16[rbp], 100	 # a[4],
 # TestCode\array.c:26:     return a[i];
	mov	eax, DWORD PTR 16[rbp]	 # tmp85, i
	cdqe
	mov	eax, DWORD PTR -32[rbp+rax*4]	 # _4, a[i_3(D)]
 # TestCode\array.c:27: }
	add	rsp, 32	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "TestCode\\array.c\0"
.LC1:
	.ascii "i > 0 && i < 4\0"
	.text
	.globl	array4
	.def	array4;	.scl	2;	.type	32;	.endef
	.seh_proc	array4
array4:
	push	rbp	 #
	.seh_pushreg	rbp
	mov	rbp, rsp	 #,
	.seh_setframe	rbp, 0
	sub	rsp, 80	 #,
	.seh_stackalloc	80
	.seh_endprologue
	mov	DWORD PTR 16[rbp], ecx	 # i, i
 # TestCode\array.c:31:     int a[] = {1, 2, 3, 4};
	mov	DWORD PTR -16[rbp], 1	 # a[0],
	mov	DWORD PTR -12[rbp], 2	 # a[1],
	mov	DWORD PTR -8[rbp], 3	 # a[2],
	mov	DWORD PTR -4[rbp], 4	 # a[3],
 # TestCode\array.c:32:     int b[] = {1, 2, 3, 4, 5};
	mov	DWORD PTR -48[rbp], 1	 # b[0],
	mov	DWORD PTR -44[rbp], 2	 # b[1],
	mov	DWORD PTR -40[rbp], 3	 # b[2],
	mov	DWORD PTR -36[rbp], 4	 # b[3],
	mov	DWORD PTR -32[rbp], 5	 # b[4],
 # TestCode\array.c:33:     assert(i > 0 && i < 4);
	cmp	DWORD PTR 16[rbp], 0	 # i,
	jle	.L10	 #,
 # TestCode\array.c:33:     assert(i > 0 && i < 4);
	cmp	DWORD PTR 16[rbp], 3	 # i,
	jle	.L13	 #,
.L10:
 # TestCode\array.c:33:     assert(i > 0 && i < 4);
	mov	r8d, 33	 #,
	lea	rax, .LC0[rip]	 # tmp89,
	mov	rdx, rax	 #, tmp89
	lea	rax, .LC1[rip]	 # tmp90,
	mov	rcx, rax	 #, tmp90
	mov	rax, QWORD PTR __imp__assert[rip]	 # tmp91,
	call	rax	 # tmp91
.L13:
 # TestCode\array.c:34:     return a[i] + b[i + 1];
	mov	eax, DWORD PTR 16[rbp]	 # tmp93, i
	cdqe
	mov	edx, DWORD PTR -16[rbp+rax*4]	 # _1, a[i_15(D)]
 # TestCode\array.c:34:     return a[i] + b[i + 1];
	mov	eax, DWORD PTR 16[rbp]	 # tmp94, i
	add	eax, 1	 # _2,
 # TestCode\array.c:34:     return a[i] + b[i + 1];
	cdqe
	mov	eax, DWORD PTR -48[rbp+rax*4]	 # _3, b[_2]
 # TestCode\array.c:34:     return a[i] + b[i + 1];
	add	eax, edx	 # _19, _1
 # TestCode\array.c:35: }
	add	rsp, 80	 #,
	pop	rbp	 #
	ret	
	.seh_endproc
	.ident	"GCC: (Rev10, Built by MSYS2 project) 12.2.0"
