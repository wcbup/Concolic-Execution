push	rbp
mov	rbp, rsp
sub	rsp, 16
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -12[rbp], 0
mov	DWORD PTR -8[rbp], 1
mov	DWORD PTR -4[rbp], 9
mov	eax, DWORD PTR 16[rbp]
cdqe
mov	eax, DWORD PTR -12[rbp+rax*4]
add	rsp, 16
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 32
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -20[rbp], 0
mov	DWORD PTR -16[rbp], 1
mov	DWORD PTR -12[rbp], 2
mov	DWORD PTR -4[rbp], 3
mov	DWORD PTR -8[rbp], 4
cmp	DWORD PTR 16[rbp], 5
jg	.L4
cmp	DWORD PTR 16[rbp], 0
js	.L4
mov	eax, DWORD PTR 16[rbp]
cdqe
mov	edx, DWORD PTR -20[rbp+rax*4]
mov	eax, DWORD PTR 16[rbp]
add	eax, 1
cdqe
mov	eax, DWORD PTR -20[rbp+rax*4]
lea	ecx, 1[rax]
mov	eax, DWORD PTR 16[rbp]
add	eax, 2
cdqe
mov	eax, DWORD PTR -20[rbp+rax*4]
imul	eax, ecx
add	eax, edx
jmp	.L6
mov	eax, 0
add	rsp, 32
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 32
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -16[rbp], 100
mov	eax, DWORD PTR 16[rbp]
cdqe
mov	eax, DWORD PTR -32[rbp+rax*4]
add	rsp, 32
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 80
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -16[rbp], 1
mov	DWORD PTR -12[rbp], 2
mov	DWORD PTR -8[rbp], 3
mov	DWORD PTR -4[rbp], 4
mov	DWORD PTR -48[rbp], 1
mov	DWORD PTR -44[rbp], 2
mov	DWORD PTR -40[rbp], 3
mov	DWORD PTR -36[rbp], 4
mov	DWORD PTR -32[rbp], 5
cmp	DWORD PTR 16[rbp], 0
jle	.L10
cmp	DWORD PTR 16[rbp], 3
jle	.L13
mov	r8d, 33
lea	rax, .LC0[rip]
mov	rdx, rax
lea	rax, .LC1[rip]
mov	rcx, rax
mov	rax, QWORD PTR __imp__assert[rip]
call	rax
mov	eax, DWORD PTR 16[rbp]
cdqe
mov	edx, DWORD PTR -16[rbp+rax*4]
mov	eax, DWORD PTR 16[rbp]
add	eax, 1
cdqe
mov	eax, DWORD PTR -48[rbp+rax*4]
add	eax, edx
add	rsp, 80
pop	rbp
ret
