; Program to add two 32-bit numbers
.model small
.data
    num1 dd 56784321h
    num2 dd 9FFF9ABCh
    result dd ?
    ; result = F6777DDDh (6309556797 decimal)

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
    ; Load the two 32-bit values
    mov ax, word ptr [num1]      ; Lower 16 bits of first number
    mov bx, word ptr [num1+2]    ; Upper 16 bits of first number
    mov cx, word ptr [num2]      ; Lower 16 bits of second number
    mov dx, word ptr [num2+2]    ; Upper 16 bits of second number

    ; Perform addition of lower words
    add ax, cx
    ; Add upper words with carry
    adc bx, dx

    ; Store result
    mov word ptr [result], ax    ; Store lower 16 bits
    mov word ptr [result+2], bx  ; Store upper 16 bits

    ; Display the result (decimal)
    mov ax, word ptr [result+2]  ; Load upper word
    call my_print_multi_digit
    mov ax, word ptr [result]    ; Load lower word
    call my_print_multi_digit

.exit
end
