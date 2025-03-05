.model small
.stack 100h
.data
a dw -3

; DONE

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, a
    test ax, ax
    js print_negative
    jmp print_positive

    print_negative:
    mov dx, '-'
    mov ah, 2
    int 21h

    MOV DX, a
    NEG DX ; MAIN PLAYER
    ;mov dx, ax
    jmp print

    print_positive:
    mov dx, a
    jmp print

    print:
    add dx, '0'
    mov ah, 2
    int 21h


    end:
    mov ah, 4ch
    int 21h
main endp
end main
