
; --------------------------------------------------------------
; Writes a loop to the console using only system calls.
; Runs on 64-bit x86 Linux only.
;
; By Jackson Naufal
; Version 1.0
; Since: 2022-11-22
; -------------------------------------------------------------

SYS_WRITE equ 1 ; write to _
SYS_EXIT equ 60 ; end program
STDOUT equ 1    ; standard output

section .bss
  length equ 2     ; length                 
  len resb length  ; hold numbers           

section .data
  newline: db 10                        ; new line      
  newlineLen: equ $-newline             ; length of the new line
  opening: db "Printing 0-9...", 10     ; first line
  openingLen: equ $-opening             ; opening
  done: db "Done.", 10                  ; second line            
  doneLen: equ $-done                   ; length of done

section .text
  global_start:                         ; entry point

  _start:
    ; prints the opening of the program
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, opening
    mov rdx, openingLen
    syscall

    ; prints the new line
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, newlineLen
    syscall

    mov r8, 48

    loop:
    mov [len], r8

    inc r8

    ; prints new line
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, len
    mov rdx, length
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, newlineLen
    syscall

    ; loop
    cmp r8, 57
    jle loop   

    ; prints new line
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, newline
    mov rdx, newlineLen
    syscall

    ; prints done
    mov rax, SYS_WRITE        
    mov rdi, STDOUT           
    mov rsi,done            
    mov rdx,doneLen           
    syscall                   

    ; ends the program
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
