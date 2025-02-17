.model small
.stack 100h
; print greater ascii character using if-then-else
.data
char_a db 'e'
char_b db 'g'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov bl, char_a
    mov bh, char_b
;    cmp char_a, char_b ; Diect comparison between memory does not work
    cmp bl, bh
    jge print_a ; if
    mov dl, char_b ; else
    jmp print

    print_a: ; then block
    mov dl, char_a

    print:
    mov ah, 2
    int 21h

    end:
    mov ax, 4c00h
    int 21h
main endp
end main
