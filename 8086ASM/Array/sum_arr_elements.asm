.model small
.stack 100h

.data
w dw 10,20,30,40,50,60,70,80,90,100
; print total sum
.code

my_print_multi_digit proc
    ; ax has the value

    ; init necessary registers
    mov bh, 0
    mov bx, 10
    mov ch, 0
    mov cx, 0

    ; Issue: Special handling for 0
    cmp ax, 0 ; jodi jull number tai zero hoy
    jne divide_them ;; input number zero na hole algo start kroe debo
    mov dx, 0
    push dx
    inc cx
    jmp print_them

    divide_them:
    mov dx, 0 ;; NECESSARY FOR DIV
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne divide_them

    print_them:
    pop dx
    add dx, '0'
    mov ah, 2
    int 21h
    loop print_them

    ret
my_print_multi_digit endp

main proc
    mov ax, @data
    mov ds, ax

    xor ax, ax    ; Redundant with the next instruction
    mov ax, 0
    mov cx, 10
    lea si, w
    SumElements:
        add ax, [si]
        add si, 2
        loop SumElements

    call my_print_multi_digit

    mov ax, 4c00h
    int 21h

main endp
end main
