.model small
.stack 100h
; WORKS
.data
lf equ 10
cr equ 13
msg1 db "Enter a lower case letter: $"
msg2 db 10, 13, "In Upper Case Letter, it is : "
char db ?, "$"

.code
main proc
    ; init DS
    mov ax, @data
    mov ds, ax

    ; first prompt
    lea dx, msg1
    mov ah, 9
    int 21h

    ; user input
    mov ah, 1
    int 21h
    sub al, 20h ; user input will be saved in AL ; subtract 20h to get lower case
    ;mov bl, al ; USELESS
    mov char, al

    ; print CHAR
    lea dx, msg2
    mov ah, 9
    int 21h

    ; exit to DOS
    mov ax, 4c00h
    int 21h
main endp
end main
