BITS 64

jmp main
%include "./lib/int.asm"
%include "./lib/screen.asm"
%include "./lib/gol.asm"

main:
  push rbp
  mov rbp, rsp

  mov qword [rbp-8], 0 ; loop

  call screen_init
  call gol_create_glider

  main_loop:
		call int_refresh_screen

    mov rdi, 1
		call int_sleep

		call gol_do_iteration

		call gol_display_buffer

		inc qword [rbp-8]
		cmp qword [rbp-8], 20
		jl main_loop

  call int_exit

  pop rbp
  ret

data:
  screen db ""
