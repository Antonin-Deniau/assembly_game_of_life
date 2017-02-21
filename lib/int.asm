int_refresh_screen:
  push rbx
  mov rbx, rsp

  mov rax, screen
  int 1

  pop rbx
  ret

; edi lenght
int_sleep:
  push rbx
  mov rbx, rsp

  mov eax, edi
  int 2

  pop rbx
  ret

int_exit:
  push rbx
  mov rbx, rsp

  int 0xFF

  pop rbx
  ret

%macro debug_params 0
	mov edi, dword [rbp-4]
	mov esi, dword [rbp-8]
	int 3
%endmacro
