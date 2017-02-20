gol_do_iteration:
  push rbx
  mov rbx, rsp

	mov dword [ebp-4], 0 ; x
	mov dword [ebp-8], 0 ; y
	mov dword [ebp-12], screen + 5000 ; buffer offset
	mov dword [ebp-16], 0 ; dot offset
	mov dword [ebp-20], 0 ; dot char

	gdi_loop_x:
	  gdi_loop_y:
			;; gol_test_cell x, y
      mov rdi, [ebp-4]
      mov rsi, [ebp-8]
      call gol_test_cell

      ;; r10 = (x * 100) + y
      mov r10, [ebp-4]
			imul r10, 100
			add r10, [ebp-8]

      ;; is_cell_alive ? "#" : " "
      mov r12, "#"
      cmp rax, 1
      je gdi_is_cell_alive
        mov r12, " "
      gdi_is_cell_alive:

      ;; [buffer + pos] = char
			mov r11, [ebp-12]
      mov [r11 + r10], r12

			;; while y <= 100
	    inc [ebp-8]
		  cmp [ebp-8], 100
		  jl gdi_loop_y

	  ;; while x <= 50
		inc [ebp-4]
		cmp [ebp-4], 50
		jl gdi_loop_x

  pop rbx
  ret

gol_display_buffer:
  push rbx
  mov rbx, rsp

	; r10 loop_counter
	; r11 char buffer
	; r12 buffer_offset
	mov r12, screen
	add r12, 5000

  mov r10, 0
  gdb_loop:
	  mov r11, [r12 + r10]
    mov [screen + r10], r11b

    inc r10
    cmp r10, 5000
    jle gdb_loop

  pop rbx
  ret

; test cell char 1 = alive 0 = dead
gol_dead_or_alive:
  push rbx
  mov rbx, rsp

  mov rax, 0
  cmp dil, "#"
  jne gdor_out
    mov rax, 1
  gdor_out:

  pop rbx
  ret

; rdi x
; rsi y
; return rax = next cell state
gol_test_cell:
  push rbx
  mov rbx, rsp

  mov r10, 0 ; alive_count
  mov r11, rdi ; x
  mov r12, rsi ; y

  %macro gtc_test_dot 0
    mov rdi, r11
    mov rsi, r12
    call screen_get_dot
    mov rdi, rax
    call gol_dead_or_alive
    add r10, rax
  %endmacro

  ; upper left
  sub r11, 1
  sub r12, 1
	gtc_test_dot
  ; upper middle
  add r11, 1
	gtc_test_dot
  ; upper right
  add r11, 1
	gtc_test_dot
  ; upper right
  add r12, 1
	gtc_test_dot
  ; upper left
  sub r11, 2
	gtc_test_dot
  ; lower left
  add r12, 1
	gtc_test_dot
  ; lower middle
  add r11, 1
	gtc_test_dot
  ; lower right
  add r11, 1
	gtc_test_dot

  ; get initial
  sub r11, 1
  sub r12, 1

  mov rdi, r11
  mov rsi, r12
  call screen_get_dot
  mov rdi, rax
  call gol_dead_or_alive

  ; test cell state
  cmp rax, 1
  je gtc_is_alive
  gtc_is_dead:
    mov rax, 0
    cmp r10, 3
    je gtc_set_alive
    jmp gtc_end

  gtc_is_alive:
    mov rax, 0
    cmp r10, 3
    je gtc_set_alive
    cmp r10, 2
    je gtc_set_alive
    jmp gtc_end

  gtc_set_alive:
    mov rax, 1
  gtc_end:
  pop rbx
  ret

%macro gol_draw_cell 2
  mov rdi, %1
  mov rsi, %2
  mov rdx, "#"
  call screen_set_dot
%endmacro

; create a test glider
gol_create_glider:
  push rbx
  mov rbx, rsp

	gol_draw_cell 2, 4
  gol_draw_cell 3, 5
  gol_draw_cell 4, 5
  gol_draw_cell 5, 3
  gol_draw_cell 5, 4
  gol_draw_cell 5, 5

  pop rbx
  ret

