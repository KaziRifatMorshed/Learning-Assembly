.model small
.stack 100h

.data
a dw 9
b dw 50
sum dw 0
rem db 0

.code
main proc
mov ax, @data
mov ds, ax

mov ax, a
add ax, b
mov sum, ax

mov ah, 0 ;; careful
;div 10 ;; can not divide a reg with direct value
mov bh, 10
div bh
mov rem, ah
mov dl, al
add dl, 48
mov ah, 2
int 21h

mov ah, 0
mov dl, rem ;; reminder ke DL e nibo print korar jonno
add dl, 48
mov ah, 2
int 21h

MOV AX, 4C00H
INT 21H

main endp
end main
;; done
