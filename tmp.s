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
cmp	DWORD PTR 16[rbp], 2
jg	.L4
cmp	DWORD PTR 16[rbp], 0
js	.L4
mov	eax, DWORD PTR 16[rbp]
cdqe
mov	eax, DWORD PTR -20[rbp+rax*4]
jmp	.L6
mov	eax, 0
add	rsp, 32
pop	rbp
ret
