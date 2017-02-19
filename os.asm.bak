BITS 64

main:
  mov rax, welcome
  int 0x1

  mov rax, buffer
  int 0x2

  mov rdx, 0
  loop:
    mov rax, hello
    int 0x1
    add rdx, 1
    cmp rdx, 10
    jle loop

  int 0xFF

strings:
  welcome db "Whats your name ?", 0
  hello db "Hello "
  buffer db ""
