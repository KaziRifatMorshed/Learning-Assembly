.model small
.stack 100h

; Search max min from arr
; DONE

.data
    p_max db "Max: $"
    p_min db 10, 13, "Min: $"
    arr dw 11,22,10,44,96,78,89
    max dw ?
    min dw ?
    len dw 7

.code

print_two_digit proc ; NOT WORKING
    ; store in ax
    mov bx, 10
    mov ah, 0
    mov dx, 0

    div bx

    ; dx e vag sesh
    add dx, '0'
    mov ah, 02h
    int 21h

    mov dx, ax
    add dx, '0'
    mov ah, 2h
    int 21h

    ret
print_two_digit endp



main proc
    mov ax, @data
    mov ds, ax

    lea si, arr
    mov cx, len

    mov ax, [si]
    mov max, ax
    mov ax, [si]
    mov min, ax
    add si, 2
    dec cx

    ; for
    looop:
        mov ax, [si]

        ; if
        check_max:
        cmp ax, max
        jle check_min
        mov max, ax

        check_min:
        cmp ax, min
        jge loop_inc
        mov min, ax


        loop_inc:
        add si, 2
        ; Don't increment cx, LOOP instruction decrements it
        loop looop
    loop_end:


    print_max:
        lea dx, p_max
        mov ah, 9
        int 21h
        mov ax, max
        call print_two_digit


    print_min:
        lea dx, p_min
        mov ah, 09h
        int 21h
        mov ax, min
        call print_two_digit


    end:
    mov ax, 4C00h
    int 21h
main endp
end main
