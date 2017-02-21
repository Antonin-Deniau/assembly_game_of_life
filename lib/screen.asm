screen_init:
  push rbx
  mov rbx, rsp

  mov r12, 0
  loop:
    mov byte [screen + r12], " "

    inc r12
    cmp r12, 5000
    jle loop

  pop rbx
  ret

; rdi x
; rsi y
screen_get_dot:
  push rbx
  mov rbx, rsp

  mov dword [rbp-4], edi ; x
  mov dword [rbp-8], esi ; y

	mov r10, 0
  mov r10d, dword [ebp-4]
  imul r10, 100
  add r10d, dword [ebp-8]
  mov al, byte [screen + r10d]

  pop rbx
  ret

; rdi x
; rsi y
; rdx char
screen_set_dot:
  push rbx
  mov rbx, rsp

  mov rax, rdi

  imul rax, 100
  add rax, rsi
  mov [screen + rax], dl

  pop rbx
  ret

; rdi x
; rsi y
screen_test_in:
  push rbx
  mov rbx, rsp

  mov rax, 0

  ; test if x > 100
	cmp rdi, 100
	jg sti_end

  ; test if x < 0
	cmp rdi, 0
	jg sti_end

  ; test if y > 50
	cmp rsi, 50
	jg sti_end

  ; test if y < 0
	cmp rsi, 0
	jg sti_end

  mov rax, 1
	sti_end:

  pop rbx
  ret
