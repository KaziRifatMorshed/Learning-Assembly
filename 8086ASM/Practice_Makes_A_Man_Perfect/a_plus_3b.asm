.model small
.stack 100h
; DONE ; a + 3 b
.data
a db ?
msg1 db "input a : $"
b db ?
msg2 db 10, 13, "input b : $"
msg3 db 10, 13, "result is : $"
sum db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov a, al

    lea dx, msg2
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    mov b, al

    mov ah, 0
    mov bl, 3
    mul bl
    ; now AL holds 3b

    mov dl, al
    add dl, a
    mov sum, dl
    add dl, 48

    mov sum, dl

    lea dx, msg3
    mov ah, 9
    int 21h

    mov ah, 2
    mov dl, sum
    int 21h

    mov ax, 4c00h
    int 21h

main endp
end main
