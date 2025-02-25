.model small
.stack 100h
; DONE
.data
a db 99
b db 89
sum db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    mov al, a
    add al, b
    mov sum, al

    ; TASK: result(sum) print korbo

    mov ah, 0
    mov bl, 100
    div bl
    ;vagfol AL e ache
    mov ch, ah
    mov dl, al
    mov ah, 2
    add dl, 48
    int 21h

    mov ah, 0
    mov al, ch
    mov bl, 10
    div bl
    mov dl, al
    mov ch, ah
    mov ah, 2
    add dl, 48
    int 21h

    mov dl, ch
    mov ah, 2
    add dl, 48
    int 21h

    mov ax, 4c00h
    int 21h
main endp
end main
