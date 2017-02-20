BITS 64

jmp main
%include "./lib/int.asm"
%include "./lib/screen.asm"
%include "./lib/gol.asm"

main:
  push rbx
  mov rbx, rsp

  call screen_init
  call gol_create_glider
  call int_refresh_screen

  mov rdi, 1
  call int_sleep

  call gol_do_iteration
  call gol_display_buffer

  call int_refresh_screen

  mov rdi, 1
  call int_sleep

  call int_exit

  pop rbx
  ret

data:
  screen db ""
