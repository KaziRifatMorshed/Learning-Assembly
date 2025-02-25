.model small
.stack 100h
;Problem: Write an assembly program that takes a 3-digit number as input from the user and then displays the same 3-digit number as output

; DONE
.data
text1 db "input a three digit number : $"
text2 db 10, 13, "the three digit number : $"
a db ?
b db ?
c db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, text1
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    mov a, al

    mov ah, 1
    int 21h
    mov b, al

    mov ah, 1
    int 21h
    mov c, al

    lea dx, text2
    mov ah, 9
    int 21h

    mov dl, a
    mov ah, 2
    int 21h

    mov dl, b
    mov ah, 2
    int 21h

    mov dl, c
    mov ah, 2
    int 21h

    mov ax, 4c00h
    int 21h
main endp
end main
