; Program to add two 32-bit numbers
.model small
.data
    num1_low dw 4321h    ; Lower 16 bits of first number
    num1_high dw 5678h   ; Higher 16 bits of first number
    num2_low dw 9ABCh    ; Lower 16 bits of second number
    num2_high dw 9FFFh  ; Higher 16 bits of second number
; asm8086 e num2_high dw 9FFFh dile overflow error ase na, but, num2_high dw A000h dile overflow error ase ?
    result_low dw ?      ; Lower 16 bits of result
    result_high dw ?     ; Higher 16 bits of result
    ; result = 6309556797

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
    ;mov ah, 0
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

.startup
    ; Load lower 16 bits of first number into AX
    mov ax, num1_low
    ; Load lower 16 bits of second number into BX
    mov bx, num2_low
    ; Add lower 16 bits
    add ax, bx
    ; Store lower 16 bits of result
    mov result_low, ax

    ; Load higher 16 bits of first number into AX
    mov ax, num1_high
    ; Load higher 16 bits of second number into BX
    mov bx, num2_high
    ; Add higher 16 bits with carry from previous addition
    adc ax, bx
    ; Store higher 16 bits of result
    mov result_high, ax

    ; At this point, result_high:result_low contains the 32-bit sum
    mov ax, result_high
    call my_print_multi_digit
    mov ax, result_low
    call my_print_multi_digit

.exit
end
