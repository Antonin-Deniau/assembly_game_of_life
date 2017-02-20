int_refresh_screen:
  push rbx
  mov rbx, rsp

  mov rax, screen
  int 0x1

  pop rbx
  ret

; edi lenght
int_sleep:
  push rbx
  mov rbx, rsp

  mov eax, edi
  int 0x2

  pop rbx
  ret

int_exit:
  push rbx
  mov rbx, rsp

  int 0xFF

  pop rbx
  ret
