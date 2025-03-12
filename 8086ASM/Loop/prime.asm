.model small
.stack 100h
; NOT COMPLETE
.data
    prime db 'this is a prime number$'
    not_prime db 'this is NOT a prime number$'
    num dw 0

.code
main proc
    mov ax, @data
    mov ds, ax

    ; input single digit
    mov ah, 1
    int 21h
    sub al, '0'
    mov ah, 0
    mov num, ax

    mov cx, ax
    dec cx

    looop:

    ; vag koro count cx diye
    mov dx, 0
    mov ax, num
    div cx
    cmp dx, 0
    je print_not_prime

    cmp cx, 1
    jg looop



    print_prime:
    lea dx, prime
    mov ah, 9
    int 21h
    jmp end

    print_not_prime:
    lea dx, not_prime
    mov ah, 9
    int 21h
    jmp end

    end:
    mov ah, 4Ch
    int 21h
main endp
end main
