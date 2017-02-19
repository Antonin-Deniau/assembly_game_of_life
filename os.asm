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

  call exit

  pop rbx
  ret

dead_or_alive: ; lol
  push rbx
  mov rbx, rsp

  mov rax, 0
  cmp rdi, "#"
  jne out
  mov rax, 1
  out:

  pop rbx
  ret

test_cell:
  push rbx
  mov rbx, rsp

  mov r10, 0 ; alive_count

  ;;;; UPPER

  ; upper left
  sub rdi, 1
  sub rsi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; upper middle
  add rdi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; upper right
  add rdi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ;;;; MIDDLE

  ; upper right
  add rsi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; upper left
  sub rdi, 2
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ;;;; LOWER

  ; lower left
  add rsi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; lower middle
  add rdi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax

  ; lower right
  add rdi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive
  add r10, rax


  ; get initial
  sub rdi, 1
  sub rsi, 1
  call get_dot
  mov rdi, rax
  call dead_or_alive


  ; Une cellule morte possédant exactement trois voisines vivantes devient vivante (elle naît).
  ; Une cellule vivante possédant deux ou trois voisines vivantes le reste, sinon elle meurt.
  cmp rax, 1
  jeq: is_alive
  is_dead:
    mov rax, 0
    cmp r10, 3
    jeq set_alive
    jmp end_test_cell:

  is_alive:
    mov rax, 0
    cmp r10, 3
    jeq set_alive
    cmp r10, 2
    jeq set_alive
    jmp end_test_cell:

    jmp end_test_cell:

  set_alive:
    mov rax, 1
  end_test_cell:
  pop rbx
  ret

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
