
; --------------------------------------------------------------
; Writes a loop to the console using only system calls.
; Runs on 64-bit x86 Linux only.
;
; By Jackson Naufal
; Version 1.0
; Since: 2022-11-22
; -------------------------------------------------------------


section .bss
    someNumber: RESD 1

section .data
    
    ; constants here
    newLine: db 10
    done: db 10, "Done.", 10
    doneLen: equ $-done

section .text
  global_start:                         ; entry point

  _start:

    mov r8, -1
    mov r9, 9 - 1

    IncrementalLabel:

        ; doing a do while loop
        inc r8
        push r8
        call PrintSingleDigitInt
        add rsp, 4
        cmp r8, 9 -1
        jle IncrementalLabel


    mov rax, 1
    mov rdi, 1
    mov rsi, done
    mov rdx, doneLen
    syscall


    ; prints new line
    mov rax, 60
    mov rdi, 0
    syscall

PrintSingleDigitInt:

    pop r14
    pop r15
    add r15, 48
    push r15

    ; prints done
    mov rax, 1   
    mov rdi, 1           
    mov rsi, rsp            
    mov rdx, 1           
    syscall                   

    mov rax, 1
    mov rdi, 1
    mov rsi, newLine
    mov rdx, 1
    syscall

    push r14
    ret
    ; ends the program
    mov rax, 1
    mov rdi, 0
    syscall
