.model small
.stack 100h
; WORKS
; prints single digit if the result is single digit
.data
a db 2
b db 3
sum db ?
text1 db "input a : $"
text2 db 10, 13, "input b : $"
text3 db 10, 13, "SUM is = $"
vagfol db ?
vagsesh db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ;promot 1
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

    ; sum operation
    mov al, a
    add al, b
    mov sum, al

    ; print text3
    lea dx, text3
    mov ah, 9
    int 21h

    ; print results
    ; first kaj: VAG KORO
    mov ah, 0
    mov al, sum
    mov bl, 10
    div bl
    mov vagfol, al
    mov vagsesh, ah

    ; checking whether first digit will be printed or not
    ; cmp vagsesh, 0 ;  LOGICAL ERROR
    cmp vagfol, 0
    je print_second_digit

    print_first_digit: ; (vagfol)
        mov dl, vagfol
        add dl, 48
        mov ah, 2
        int 21h

    print_second_digit: ; (vagsesh)
        mov dl, vagsesh
        add dl, 48
        mov ah, 2
        int 21h

    mov ax, 4300h
    int 21h
main endp
end main
