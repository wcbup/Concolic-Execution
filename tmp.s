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
