push	rbp
mov	rbp, rsp
nop
pop	rbp
ret
push	rbp
push	ebx
sub	rsp, 40
lea	rbp, 32[rsp]
mov	DWORD PTR 32[rbp], ecx
cmp	DWORD PTR 32[rbp], 0
jg	.L4
mov	eax, 0
jmp	.L5
cmp	DWORD PTR 32[rbp], 1
jne	.L6
mov	eax, 1
jmp	.L5
mov	eax, DWORD PTR 32[rbp]
sub	eax, 1
mov	ecx, eax
call	fib1
mov	ebx, eax
mov	eax, DWORD PTR 32[rbp]
sub	eax, 2
mov	ecx, eax
call	fib1
add	eax, ebx
add	rsp, 40
pop	ebx
pop	rbp
ret
push	rbp
push	ebx
sub	rsp, 40
lea	rbp, 32[rsp]
mov	DWORD PTR 32[rbp], ecx
cmp	DWORD PTR 32[rbp], 0
jg	.L8
cmp	DWORD PTR 32[rbp], 0
jns	.L9
call	userDefinedException
mov	eax, 0
jmp	.L10
cmp	DWORD PTR 32[rbp], 1
jne	.L11
mov	eax, 1
jmp	.L10
mov	eax, DWORD PTR 32[rbp]
sub	eax, 1
mov	ecx, eax
call	fib2
mov	ebx, eax
mov	eax, DWORD PTR 32[rbp]
sub	eax, 2
mov	ecx, eax
call	fib2
add	eax, ebx
add	rsp, 40
pop	ebx
pop	rbp
ret
push	rbp
push	ebx
sub	rsp, 40
lea	rbp, 32[rsp]
mov	DWORD PTR 32[rbp], ecx
cmp	DWORD PTR 32[rbp], 0
jns	.L15
mov	r8d, 46
lea	rax, .LC0[rip]
mov	rdx, rax
lea	rax, .LC1[rip]
mov	rcx, rax
mov	rax, QWORD PTR __imp__assert[rip]
call	rax
cmp	DWORD PTR 32[rbp], 0
jg	.L16
cmp	DWORD PTR 32[rbp], 0
jns	.L17
call	userDefinedException
mov	eax, 0
jmp	.L18
cmp	DWORD PTR 32[rbp], 1
jne	.L19
mov	eax, 1
jmp	.L18
cmp	DWORD PTR 32[rbp], 100
jle	.L20
call	userDefinedException
mov	eax, DWORD PTR 32[rbp]
sub	eax, 1
mov	ecx, eax
call	fib3
mov	ebx, eax
mov	eax, DWORD PTR 32[rbp]
sub	eax, 2
mov	ecx, eax
call	fib3
add	eax, ebx
add	rsp, 40
pop	ebx
pop	rbp
ret
