push	rbp
mov	rbp, rsp
sub	rsp, 16
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR -4[rbp], 0
mov	eax, DWORD PTR 16[rbp]
cdq
idiv	DWORD PTR -4[rbp]
add	rsp, 16
pop	rbp
ret
push	rbp
mov	rbp, rsp
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR 24[rbp], edx
mov	eax, DWORD PTR 16[rbp]
cdq
idiv	DWORD PTR 24[rbp]
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 32
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR 24[rbp], edx
cmp	DWORD PTR 24[rbp], 0
jne	.L8
mov	r8d, 17
lea	rax, .LC0[rip]
mov	rdx, rax
lea	rax, .LC1[rip]
mov	rcx, rax
mov	rax, QWORD PTR __imp__assert[rip]
call	rax
mov	eax, DWORD PTR 16[rbp]
cdq
idiv	DWORD PTR 24[rbp]
add	rsp, 32
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 16
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR 24[rbp], edx
mov	DWORD PTR -4[rbp], 9
mov	eax, DWORD PTR 16[rbp]
cdq
idiv	DWORD PTR -4[rbp]
mov	DWORD PTR -4[rbp], eax
mov	eax, DWORD PTR -4[rbp]
cmp	eax, DWORD PTR 24[rbp]
jle	.L11
mov	eax, DWORD PTR -4[rbp]
cdq
idiv	DWORD PTR 24[rbp]
jmp	.L12
mov	eax, DWORD PTR 16[rbp]
cdq
idiv	DWORD PTR 24[rbp]
add	rsp, 16
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 16
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR 24[rbp], edx
mov	DWORD PTR -4[rbp], 9
jmp	.L14
mov	eax, DWORD PTR 24[rbp]
cdq
idiv	DWORD PTR -4[rbp]
mov	DWORD PTR 16[rbp], eax
mov	eax, DWORD PTR 16[rbp]
cmp	eax, DWORD PTR 24[rbp]
jg	.L15
mov	eax, DWORD PTR 16[rbp]
add	rsp, 16
pop	rbp
ret
push	rbp
mov	rbp, rsp
sub	rsp, 16
mov	DWORD PTR 16[rbp], ecx
mov	DWORD PTR 24[rbp], edx
mov	DWORD PTR -4[rbp], 9
mov	eax, DWORD PTR -4[rbp]
imul	eax, DWORD PTR 24[rbp]
cdq
idiv	DWORD PTR 16[rbp]
mov	DWORD PTR 16[rbp], eax
mov	eax, DWORD PTR 16[rbp]
imul	eax, DWORD PTR 24[rbp]
mov	edx, eax
mov	eax, DWORD PTR -4[rbp]
add	eax, edx
mov	DWORD PTR 24[rbp], eax
mov	eax, DWORD PTR 16[rbp]
cmp	eax, DWORD PTR 24[rbp]
jle	.L18
mov	eax, DWORD PTR -4[rbp]
cdq
idiv	DWORD PTR 16[rbp]
mov	edx, eax
mov	eax, DWORD PTR 24[rbp]
add	eax, edx
jmp	.L19
mov	eax, DWORD PTR 16[rbp]
add	rsp, 16
pop	rbp
ret
