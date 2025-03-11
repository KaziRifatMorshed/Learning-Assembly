; 1*x+2*x+……+n*x = ?

.model small
.stack 100h

.data
x dw ?
sum dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; take input
    mov cx, ax

    sum_loop:

    ; update sum
    mov dx, sum
    add dx, ax
    mov sum, dx


    mov ah, 4ch
    int 21h
main endp
end main
