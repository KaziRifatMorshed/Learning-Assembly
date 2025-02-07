// nasm -f elf64 print3.asm & ld -o print3 print3.o
; nasm -f elf64 print3.asm & ld -o print3 print3.o

section .data
    message db "3", 10  ; The string to print ("3" followed by a newline)
    len equ $-message   ; Calculate the length of the message

section .text
    global _start

_start:
    ; Write the string to stdout
    mov rax, 1          ; System call number for write
    mov rdi, 1          ; File descriptor for stdout (standard output)
    mov rsi, message    ; Address of the string to print
    mov rdx, len        ; Length of the string to print
    syscall             ; Make the system call

    ; Exit the program
    mov rax, 60         ; System call number for exit
    mov rdi, 0          ; Exit code 0 (success)
    syscall             ; Make the system call