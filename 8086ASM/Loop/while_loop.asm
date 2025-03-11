; basic loop
; print stars
.model small
.stack 100h
.data

.code
main proc
    mov ax, @data
    mov ds, ax


    while:
    mov ah, 1
    int 21h
    cmp ax, 13
    je end_while

    end_while:

    mov ah, 4ch
    int 21h
main endp
end main ; DONE
