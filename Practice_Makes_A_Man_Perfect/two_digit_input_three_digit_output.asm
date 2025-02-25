.model small
.stack 100h
; PENDING ; NEED EDIT
.data
a db 2
b db 3
sum db ?
text1 db "input a : $"
text2 db "input b : $"
text3 db "SUM is = $"

.code
main proc
    mov ax, @data
    mov ds, ax

    ; promot 1
    lea dx, text1
    mov ah, 9
    int 21h

    ; input a
    mov ah, 1
    int 21h
    sub al, 48
    mov a, al

    ; prompt 2
    lea dx, text2
    mov ah, 9
    int 21h

    ; input b
    mov ax, 0 ; extra cure
    mov ah, 1
    int 21h
    sub al, 48
    mov b, al

    ; print new line again
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h

    ; sum operation
    mov al, a
    add al, b
    mov sum, al

    ; print new line
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h

    ; print text3
    lea dx, text3
    mov ah, 9
    int 21h

    ; print operation
    mov dl, sum
    add dl, 48 ; --------- ASCII ----- vule gesilam
    mov ah, 2
    int 21h

    mov ax, 4300h
    int 21h
main endp
end main
