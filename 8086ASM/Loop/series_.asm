; 1*x+2*x+……+n*x = ?

.model small
.stack 100h

.data
x dw 3
n dw ?
sum dw 0
msg1 db 10, 13, "Sum is : $"
; DONE

.code
my_print_multi_digit proc
    ; ax has the value

    ; init necessary registers
    mov bh, 0
    mov bx, 10
    mov ch, 0
    mov cx, 0

    divide_them:
    mov ah, 0
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

    ; take input n
    mov ah, 1
    int 21h
    mov ah, 0 ; AH zero kora lagbe noile AX = 01 04 ; emon hoye thakbe and oita CX e copy hobe
    sub ax, '0'
    mov n, ax
    mov cx, ax

    sum_loop:
    mov ax, x
    mul cx
    add ax, sum
    ;add sum, ax
    mov sum, ax
    loop sum_loop
    ;loop_end:

    print_sum:
    lea dx, msg1
    mov ah, 9
    int 21h

    mov ax, sum
    call my_print_multi_digit

    end:
    mov ah, 4ch
    int 21h
main endp
end main
