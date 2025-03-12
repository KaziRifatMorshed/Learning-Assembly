.model small
.stack 100h

.data
    p db '+$'
    a dw 0
    b dw 0
    n dw 0
    count dw 0

.code
print_multi_digit proc
    mov bh, 0
    mov bx, 10
    mov ch, 0
    mov cx, 0

    divide_them:
    mov ah, 0
    mov dx, 0
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
print_multi_digit endp

main proc
    mov ax, @data
    mov ds, ax

    ; input n
    mov ah, 1
    int 21h
    sub ax, '0'
    mov ah, 0
    mov n, ax

    mov ax, 1

    loooop:
    mov cx, count
    cmp cx, n
    je end

    add sum, ax
    call print_multi_digit

    lea dx, p
    mov ah, 9
    int 21h

    mov cx, count
    inc cx
    cmp cx, n
    jle loooop


    end:
    mov ah, 4Ch
    int 21h
main endp
end main
