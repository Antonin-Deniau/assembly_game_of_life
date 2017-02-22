BITS 64

jmp main
%include "./lib/int.asm"
%include "./lib/screen.asm"
%include "./lib/gol.asm"

main:
  push rbp
  mov rbp, rsp
	sub rsp, 16

  mov qword [rbp-8], 0 ; loop

  call screen_init

	mov rdi, 10
	mov rsi, 10
  call gol_create_glider

	mov rdi, 5
	mov rsi, 20
  call gol_create_pentadecathlon

  main_loop:
		call int_refresh_screen

    mov rdi, 330
		call int_sleep

		call gol_do_iteration

		int 4
		mov [screen + 5010], al

		call gol_display_buffer

		inc qword [rbp-8]
		cmp qword [rbp-8], 200
		jl main_loop

  call int_exit

  leave
  ret

data:
  screen db ""
