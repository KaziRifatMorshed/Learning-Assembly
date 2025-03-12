; basic loop
; count number of inputted characters
.model small
.stack 100h
.data

.code
main proc
    mov ax, @data
    mov ds, ax
    mov cx, 0

    while:
    mov ah, 1
    int 21h
    cmp ax, 13 // DOES NOT WORK
    cmp al, 13
    je end_while
    inc cx
    jmp while
    end_while:

    mov ah, 4ch
    int 21h
main endp
end main ; DONE
