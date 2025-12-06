# my first asm program

.global _start

.section .text

_start:
    movq $60, %rax
    movq $3, %rdi
    syscall
    
;     .global main
;     .text
; main:
;     mov     $60, %rax       # syscall: exit
;     xor     %rdi, %rdi      # status: 0
;     syscall