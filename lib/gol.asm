gol_do_iteration:
	push rbp
	mov rbp, rsp
	sub rsp, 24

  mov qword [rbp-8], 0 ; x
  mov qword [rbp-16], 0 ; y

  gdi_loop_x:
    gdi_loop_y:
      ;; gol_test_cell x, y
      mov rdi, qword [rbp-8]
      mov rsi, qword [rbp-16]
      call gol_test_cell

      ;; is_cell_alive ? "#" : " "
      mov r12, "#"
      cmp rax, 1
      je gdi_is_cell_alive
        mov r12, " "
      gdi_is_cell_alive:

      ;; r10 = (y * 100) + x
      mov r10, qword [rbp-16]
      imul r10, 100
      add r10, qword [rbp-8]

      ;; [buffer + pos] = char
      mov r11, screen + 5000
      mov [r11 + r10], r12b

      ;; while y <= 50
      inc qword [rbp-16]
      cmp qword [rbp-16], 50
      jle gdi_loop_y

    mov qword [rbp-16], 0

    ;; while x <= 50
    inc qword [rbp-8]
    cmp qword [rbp-8], 100
    jle gdi_loop_x

  leave
  ret

gol_display_buffer:
	push rbp
	mov rbp, rsp
	sub rsp, 16

  mov qword [rbp-8], 0 ; offset

  gdb_loop:
    mov r10, screen + 5000  ; buffer_addr
    mov r11, [rbp-8] ; offset

    mov r12b, byte [r10 + r11]    ; char = [buffer_addr + offset]
    mov byte [screen + r11], r12b ; [screen + offset] = char

		inc qword [rbp-8]
    cmp qword [rbp-8], 5000
    jle gdb_loop

  leave
  ret

; test cell char 1 = alive 0 = dead
gol_dead_or_alive:
  push rbp
  mov rbp, rsp

  mov rax, 0
  cmp dil, "#"
  jne gdor_out
    mov rax, 1
  gdor_out:

  pop rbp
  ret

; rdi x
; rsi y
; return rax = next cell state
gol_test_cell:
  push rbp
  mov rbp, rsp
	sub rsp, 30

  mov qword [rbp-8], rdi  ; x
  mov qword [rbp-16], rsi ; y
  mov qword [rbp-24], 0

  %macro gtc_test_dot 1
    ;; Manage walls
    ;mov rdi, qword [rbp-8]
    ;mov rsi, qword [rbp-16]

		;call screen_test_in

		;cmp rax, 1
		;jne gtc_macro_end_%1
	  ;add [rbp-24], rax
	  ;jmp gtc_macro_end_%1

    ;;  Test if dead or alive
    mov rdi, [rbp-8]
    mov rsi, [rbp-16]
    call screen_get_dot

    mov rdi, rax
    call gol_dead_or_alive
    add [rbp-24], rax

		;gtc_macro_end_%1:
  %endmacro

  ; upper left
  sub qword [rbp-16], 1 ; y = -1
  sub qword [rbp-8], 1  ; x = -1
  gtc_test_dot ul
  ; upper middle
  add qword [rbp-8], 1  ; x = 0
  gtc_test_dot um
  ; upper right
  add qword [rbp-8], 1  ; x = 1
  gtc_test_dot ur

  ; middle right
  add qword [rbp-16], 1  ; y = 0 
  gtc_test_dot mr
  ; middle left
  sub qword [rbp-8], 2   ; x = -1
	gtc_test_dot ml

  ; lower left
  add qword [rbp-16], 1  ; y = 1
  gtc_test_dot ll
  ; lower middle
  add qword [rbp-8], 1   ; x = 0
  gtc_test_dot lm
  ; lower right
  add qword [rbp-8], 1   ; x = 1
  gtc_test_dot lr

  ; get initial
  sub qword [rbp-8], 1
  sub qword [rbp-16], 1

  mov rdi, qword [rbp-8]
  mov rsi, qword [rbp-16]
  call screen_get_dot
  mov rdi, rax
  call gol_dead_or_alive

  ; test cell state
	; Une cellule morte possédant exactement trois voisines vivantes devient vivante (elle naît).
	; Une cellule vivante possédant deux ou trois voisines vivantes le reste, sinon elle meurt.
  cmp rax, 1
  je gtc_is_alive
  gtc_is_dead:
    mov rax, 0
    cmp qword [rbp-24], 3
    je gtc_set_alive
    jmp gtc_end

  gtc_is_alive:
    mov rax, 0
    cmp qword [rbp-24], 3
    je gtc_set_alive
    cmp qword [rbp-24], 2
    je gtc_set_alive
    jmp gtc_end

  gtc_set_alive:
    mov rax, 1
  gtc_end:

  leave
  ret

%macro gol_draw_cell 2
	mov rdi, [rbp-8]
	mov rsi, [rbp-16]

	add rdi, %1
	add rsi, %2

	mov rdx, "#"
	call screen_set_dot
%endmacro

gol_create_glider:
	push rbp
	mov rbp, rsp
	sub rsp, 24

  mov qword [rbp-8],  rdi ; x
  mov qword [rbp-16], rsi ; y

  gol_draw_cell 1, 0
  gol_draw_cell 2, 1
  gol_draw_cell 0, 2
  gol_draw_cell 1, 2
  gol_draw_cell 2, 2

  leave
  ret

gol_create_pentadecathlon:
	push rbp
	mov rbp, rsp
	sub rsp, 24

  mov qword [rbp-8],  rdi ; x
  mov qword [rbp-16], rsi ; y

  gol_draw_cell 1, 0
  gol_draw_cell 1, 1

  gol_draw_cell 0, 2
  gol_draw_cell 2, 2

  gol_draw_cell 1, 3
  gol_draw_cell 1, 4
  gol_draw_cell 1, 5
  gol_draw_cell 1, 6

  gol_draw_cell 0, 7
  gol_draw_cell 2, 7

  gol_draw_cell 1, 8
  gol_draw_cell 1, 9

  leave
  ret
