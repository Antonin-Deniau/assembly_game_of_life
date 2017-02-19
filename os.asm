BITS 64

jmp main
%include "./api.asm"

main:
  push rbx
  mov rbx, rsp

  call init_screen

  mov rdi, 2
  mov rsi, 2
  mov rdx, "A"
  call draw_dot

  call refresh_screen

  mov rdi, 2
  mov rsi, 4
  mov rdx, "*"
  call draw_dot

  mov rdi, 1
  call sleep

  call refresh_screen

  mov rdi, 1
  call sleep

  call exit

  pop rbx
  ret

data:
  screen db ""
