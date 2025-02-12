; if (a>=b && b<c) then print 'Y' else print 'N'
.model small
.stack 100h

.data
a db 23
b db 9
c db 10

.code
main proc

    mov ax, @data
    mov ds, ax

    mov al, a
    mov bl, b
    mov cl, c

    ; check a>=b
    cmp al, bl
    jl printN

    ; check b < c
    cmp bl, cl
    jge printN

    ; if both conditions were true
    jmp printY

    printY:
    mov dl, 'Y'
    jmp print

    printN:
    mov dl, 'N'
    jmp print

    print:
    mov ah, 2
    int 21h

    mov ax, 4c00h
    int 21h

main endp
end main
