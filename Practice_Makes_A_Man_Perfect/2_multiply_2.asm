.model small
.stack 100h

; DONE
.code
main proc

    mov ax, 0
    mov al, 2
    mov bl, 2
    mul bl

    mov dl, al
    add dl, 48
    mov ah, 2
    int 21h

    mov ax, 4c00h
    int 21h
main endp
end main
