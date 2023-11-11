push	rbp
push	ebx
sub	rsp, 40
lea	rbp, 32[rsp]
mov	DWORD PTR 32[rbp], ecx
cmp	DWORD PTR 32[rbp], 0
jg	.L2
mov	eax, 0
jmp	.L3
cmp	DWORD PTR 32[rbp], 1
jne	.L4
mov	eax, 1
jmp	.L3
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
jg	.L6
cmp	DWORD PTR 32[rbp], 0
jns	.L7
call	userDefinedException
mov	eax, 0
jmp	.L8
cmp	DWORD PTR 32[rbp], 1
jne	.L9
mov	eax, 1
jmp	.L8
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
jns	.L13
mov	r8d, 44
lea	rax, .LC0[rip]
mov	rdx, rax
lea	rax, .LC1[rip]
mov	rcx, rax
mov	rax, QWORD PTR __imp__assert[rip]
call	rax
cmp	DWORD PTR 32[rbp], 0
jg	.L14
cmp	DWORD PTR 32[rbp], 0
jns	.L15
call	userDefinedException
mov	eax, 0
jmp	.L16
cmp	DWORD PTR 32[rbp], 1
jne	.L17
mov	eax, 1
jmp	.L16
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
