BITS 64

jmp main
%include "./api.asm"

main:
  push rbx
  mov rbx, rsp

  call init_screen
  call create_glider

  call refresh_screen

  mov rdi, 1
  call sleep

  mov rdi, 1
  call sleep

  call exit

  pop rbx
  ret

test_all_cells:
  mov r10, 0 ; x
  mov r11, 0 ; y
  mov r12, screen + 5000 ; buffer offset
	;   r13 scratch var ; dot offset
	;   r14 scratch var ; dot char

  ; ;----100-y----;
  ; ;             ; 
  ; 50 x          ;
  ; ;             ; 
  ; ;-------------;

	loop_x:
	  loop_y:
			;; LOOP

      mov rdi, r10
      mov rsi, r11
      call test_cell

      mov r14, "#"
      cmp rax, 1
      je is_dot_alive
        mov r14, " "
      is_dot_alive:

      mov r13, r10   ; offset = x
			imul r13, 100  ; offset = offset * 100 
			add r13, r11   ; offset = offset + y
      mov byte [r12 + r13], r14

			;; END
	    inc r11
		  cmp r11, 100
		  jl loop_y
		;; 
		inc r10
		cmp r10, 50
		jl loop_x

copy_buffer_to_screen:
  push rbx
  mov rbx, rsp

	; r10 loop_counter
	; r11 char buffer
	; r12 buffer_offset
	mov r12, screen
	add r12, 5000

  mov r10, 0
  loop:
	  mov r11, [r12 + r10]
    mov byte [screen + r10], r11

    inc r10
    cmp r10, 5000
    jle loop

  pop rbx
  ret

; test cell char 1 = alive 0 = dead
dead_or_alive:
  push rbx
  mov rbx, rsp

  mov rax, 0
  cmp dil, "#"
  jne out
  mov rax, 1
  out:

  pop rbx
  ret

; rdi x
; rsi y
; return rax = next cell state
test_cell:
  push rbx
  mov rbx, rsp

  mov r10, 0 ; alive_count
  mov r11, rdi ; x
  mov r12, rsi ; y

  ;;;; UPPER

  ; upper left
  sub r11, 1
  sub r12, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; upper middle
  add r11, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; upper right
  add r11, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ;;;; MIDDLE

  ; upper right
  add r12, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; upper left
  sub r11, 2

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ;;;; LOWER

  ; lower left
  add r12, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; lower middle
  add r11, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; lower right
  add r11, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; get initial
  sub r11, 1
  sub r12, 1

  mov rdi, r11
  mov rsi, r12
  call get_dot
  mov rdi, rax
  call dead_or_alive

  ; test cell state
  cmp rax, 1
  je is_alive
  is_dead:
    mov rax, 0
    cmp r10, 3
    je set_alive
    jmp end_test_cell

  is_alive:
    mov rax, 0
    cmp r10, 3
    je set_alive
    cmp r10, 2
    je set_alive
    jmp end_test_cell

    jmp end_test_cell

  set_alive:
    mov rax, 1
  end_test_cell:
  pop rbx
  ret

; create a test glider
create_glider:
  push rbx
  mov rbx, rsp

  mov rdi, 2
  mov rsi, 4
  mov rdx, "#"
  call draw_dot
  mov rdi, 3
  mov rsi, 5
  mov rdx, "#"
  call draw_dot
  mov rdi, 4
  mov rsi, 5
  mov rdx, "#"
  call draw_dot
  mov rdi, 5
  mov rsi, 3
  mov rdx, "#"
  call draw_dot
  mov rdi, 5
  mov rsi, 4
  mov rdx, "#"
  call draw_dot
  mov rdi, 5
  mov rsi, 5
  mov rdx, "#"
  call draw_dot

  pop rbx
  ret

data:
  screen db ""
