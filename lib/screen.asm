screen_init:
  push rbp
  mov rbp, rsp

  mov r12, 0
  loop:
    mov byte [screen + r12], " "

    inc r12
    cmp r12, 5000
    jle loop

  pop rbp
  ret

; rdi x
; rsi y
screen_get_dot:
  push rbp
  mov rbp, rsp

  mov qword [rbp-8], rdi ; x
  mov qword [rbp-16], rsi ; y

  mov r10, qword [ebp-16]
  imul r10, 100
  add r10, qword [ebp-8]
  mov al, byte [screen + r10]

  pop rbp
  ret

; rdi x
; rsi y
; rdx char
screen_set_dot:
  push rbp
  mov rbp, rsp

  mov qword [rbp-8], rdi ; x
  mov qword [rbp-16], rsi ; y

  mov r10, qword [ebp-16]
  imul r10, 100
  add r10, qword [ebp-8]
  mov [screen + r10], dl

  pop rbp
  ret

; rdi x
; rsi y
screen_test_in:
  push rbp
  mov rbp, rsp

  mov rax, 0

  ; test if x > 100
	cmp rdi, 100
	jg sti_end

  ; test if y > 50
	cmp rsi, 50
	jg sti_end

  mov rax, 1
	sti_end:

  pop rbp
  ret
