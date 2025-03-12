.model small
.stack 100h

.data
nl db 10,13
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
    ; init
    mov cx, 1
    mov bx, 2

    check:
    cmp cx, 20
    je end

    mov ax, cx
    mov dx, 0 ;; necessary for division
    div bx

    cmp dx, 0
    je even
    jne odd

    even:
    mov ax, cx
    call print_multi_digit
    lea dx, nl
    mov ah, 9
    int 21h
    ;inc cx ; let odd be executed, better idea
    ;jmp check ; let odd be executed, better idea
    odd:
    inc cx
    jmp check

    end:
    mov ah, 4ch
    int 21h
main endp
end main
