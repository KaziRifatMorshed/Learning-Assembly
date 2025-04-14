.MODEL SMALL
.STACK 100h

.DATA
text db "abcdef$"
len dw 6

; WORKS

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    lea si, text

    lea di, text
    add di, len
    dec di

    mov cx, len
    shr cx, 1

    reverse_loop:
        mov al, [si]
        mov bl, [di]
        mov [di], al
        mov [si], bl

        inc si
        dec di

        loop reverse_loop

    lea dx, text
    mov ah, 9
    int 21h

    MOV AX, 4C00h
    INT 21h
MAIN ENDP
END MAIN
