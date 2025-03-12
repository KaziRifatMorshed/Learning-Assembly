.model small
.stack 100h

.data
num dw 2
times dw 20
; DONE

.code
print_multi_digit proc
    mov bh, 0
    mov bx, 10
    mov ch, 0
    mov cx, 0

    ; AX has the value
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

    ;mov ax, num ; 2 beshi jog kora hoye jabe
    mov ax, 0
    mov cx, times
    looooop:
    add ax, num
    loop looooop
    call print_multi_digit
    mov ah, 4ch
    int 21h
main endp
end main
