BITS 64

main:
  push rbx
  mov rbx, rsp

  call init_screen

  mov byte [screen + 5], "A"

  call refresh_screen
  
  call sleep

  call exit

  pop rbx
  ret

exit:
  push rbx
  mov rbx, rsp

  int 0xFF

  pop rbx
  ret

sleep:
  push rbx
  mov rbx, rsp

  mov rax, 2
  int 0x2

  pop rbx
  ret

refresh_screen:
  push rbx
  mov rbx, rsp

  mov rax, screen
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

data:
  screen db ""
