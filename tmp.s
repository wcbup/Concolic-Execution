push	rbp
mov	rbp, rsp
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR 24[rbp], edx
mov	DWORD PTR 32[rbp], r8d
mov	DWORD PTR 40[rbp], r9d
mov	edx, DWORD PTR 16[rbp]
mov	eax, DWORD PTR 24[rbp]
add	edx, eax
mov	eax, DWORD PTR 32[rbp]
add	edx, eax
mov	eax, DWORD PTR 40[rbp]
add	edx, eax
mov	eax, DWORD PTR 48[rbp]
add	edx, eax
mov	eax, DWORD PTR 56[rbp]
add	edx, eax
mov	eax, DWORD PTR 64[rbp]
add	eax, edx
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 80
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -4[rbp], 2
mov	DWORD PTR -8[rbp], 3
mov	edx, DWORD PTR -8[rbp]
mov	eax, edx
sal	eax, 3
sub	eax, edx
mov	DWORD PTR -8[rbp], eax
sub	DWORD PTR -4[rbp], 1
mov	eax, DWORD PTR 16[rbp]
cdq
idiv	DWORD PTR -4[rbp]
imul	eax, eax, 77
mov	DWORD PTR -8[rbp], eax
mov	r9d, DWORD PTR -4[rbp]
mov	r8d, DWORD PTR -8[rbp]
mov	edx, DWORD PTR -4[rbp]
mov	eax, DWORD PTR -4[rbp]
mov	ecx, DWORD PTR -4[rbp]
mov	DWORD PTR 48[rsp], ecx
mov	ecx, DWORD PTR -4[rbp]
mov	DWORD PTR 40[rsp], ecx
mov	ecx, DWORD PTR 16[rbp]
mov	DWORD PTR 32[rsp], ecx
mov	ecx, eax
call	sum
add	DWORD PTR -8[rbp], eax
mov	edx, DWORD PTR 16[rbp]
mov	eax, DWORD PTR -4[rbp]
add	edx, eax
mov	eax, DWORD PTR -8[rbp]
add	eax, edx
add	rsp, 80
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 16
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -4[rbp], 0
jmp	.L6
mov	eax, DWORD PTR 16[rbp]
add	DWORD PTR -4[rbp], eax
sub	DWORD PTR 16[rbp], 1
cmp	DWORD PTR 16[rbp], 0
jg	.L7
mov	eax, DWORD PTR -4[rbp]
add	rsp, 16
pop	rbp
ret
push	rbp
push	ebx
sub	rsp, 40
lea	rbp, 32[rsp]
mov	DWORD PTR 32[rbp], ecx
cmp	DWORD PTR 32[rbp], 0
jg	.L10
mov	eax, 0
jmp	.L11
cmp	DWORD PTR 32[rbp], 1
jne	.L12
mov	eax, 1
jmp	.L11
mov	eax, DWORD PTR 32[rbp]
sub	eax, 1
mov	ecx, eax
call	fib
mov	ebx, eax
mov	eax, DWORD PTR 32[rbp]
sub	eax, 2
mov	ecx, eax
call	fib
add	eax, ebx
add	rsp, 40
pop	ebx
pop	rbp
ret
