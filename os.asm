BITS 64

main:
  mov rax, welcome
  int 0x1

  mov rax, buffer
  int 0x2

  mov rax, hello
  int 0x1

	int 0xFF

strings:
  welcome db "Whats your name", 0
  hello db "Hello", 0
	buffer db ""

; print 1
; read  2

; EAX    Syscall number / return value
; EBX    params 1
; ECX    params 2
; EDX    params 3
; ESI    params 4
; EDI    params 5
; EBP    params 6
