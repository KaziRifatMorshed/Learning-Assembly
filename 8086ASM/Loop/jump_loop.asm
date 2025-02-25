.model small
.stack 100h

.code
main proc

mov cx, 5
mov bx, 0

ghuro:
mov dx, bx
add dx, '0'
mov ah, 2
int 21h
inc bx
dec cx
JNZ ghuro ; KEEP GOING IF cx NOT EQUALS TO ZERO

thamo:
mov ax, 4c00h
int 21h

main endp
end main
; OUTPUT 01234
