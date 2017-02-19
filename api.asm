; rdi x
; rsi y
; rdx char
draw_dot:
  push rbx
  mov rbx, rsp

  imul rdi, 100
  add rdi, rsi
  mov [screen + rdi], dl

  pop rbx
  ret

exit:
  push rbx
  mov rbx, rsp

  int 0xFF

  pop rbx
  ret

; edi lenght
sleep:
  push rbx
  mov rbx, rsp

  int 0x2

  pop rbx
  ret

refresh_screen:
  push rbx
  mov rbx, rsp

  mov rdi, screen
  int 0x1

  pop rbx
  ret

init_screen:
  push rbx
  mov rbx, rsp

  mov r12, 0
  loop:
    mov byte [screen + r12], 0x20

    inc r12
    cmp r12, 5000
    jle loop

  pop rbx
  ret
