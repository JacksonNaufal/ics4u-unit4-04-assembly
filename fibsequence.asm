
; --------------------------------------------------------------------|
; Writes a loop to the console using only system calls.               |
; Runs on 64-bit x86 Linux only.                                      |
;                                                                     |
; By Jackson Naufal                                                   |
; Version 1.0                                                         |
; Since: 2022-11-22                                                   |
; --------------------------------------------------------------------|

;---------------------------------------------------------------------|
; Reference                                                           |
; https://sites.google.com/ocsb.ca/teh-ics4ur/units/unit-4/unit-4-04  |
;---------------------------------------------------------------------|



section .bss
    ; someNumber
    someNumber: RESD 1

section .data
    
    ; constants here
    newLine: db 10
    done: db 10, "Done.", 10
    doneLen: equ $-done

section .text
  ; entry point
  global_start:                       

  _start:                              
    mov r8, 1                          
    mov r9, 0                        
    mov r10, 1                       
    mov r11, 0                      

    IncrementLabel:
      ; doing a do while loop!
      inc r8
      push r9
      ; calls our single digit function
      call PrintSingleDigitInt 

      ; addition
      mov r11, r9
      add r11, r10

      ; update
      mov r9, r10
      mov r10, r11

      add rsp, 4                
      cmp r8, 8-1                
      jle IncrementLabel        

      ; write done
      mov rax, 1                 
      mov rdi, 1               
      mov rsi, done              
      mov rdx, doneLen           
      syscall                  

      mov rax, 60               
      mov rdi, 0                
      syscall                    

PrintSingleDigitInt:
  ; functions called, return value is placed on the stack
  pop r14                  
  pop r15                    
  add r15, 48                
  push r15                   

  ; writes value on the stack
  mov rax, 1                  
  mov rdi, 1                
  mov rsi, rsp                
  mov rdx, 1               
  syscall                    

  ; print a new line
  mov rax, 1                 
  mov rdi, 1                  
  mov rsi, newLine           
  mov rdx, 1                 
  syscall                   

  push r14                   
  ; return
  ret                        
