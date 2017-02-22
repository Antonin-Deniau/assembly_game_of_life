int_refresh_screen:
  push rbp
  mov rbp, rsp

  mov rax, screen
  int 1

  pop rbp
  ret

; edi lenght
int_sleep:
  push rbp
  mov rbp, rsp

  mov rax, rdi
  int 2

  pop rbp
  ret

int_exit:
  push rbp
  mov rbp, rsp

  int 0xFF

  pop rbp
  ret

