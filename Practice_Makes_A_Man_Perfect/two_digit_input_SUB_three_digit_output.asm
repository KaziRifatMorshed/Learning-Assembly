.model small
.stack 100h

; WORKS
.data
a db 0
b db 0
sum db 0
subtract db ?
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

    input_a: ; {
    mov ah, 1
    int 21h
    sub al, 48

    mov ah, 0
    mov bl, 10
    mul bl
    mov cl, al

    mov ah, 1
    int 21h
    sub al, 48
    add cl, al

    done_a:
    mov a, cl
    ; }

    prompt2:
    lea dx, text2
    mov ah, 9
    int 21h

    input_b: ; {
    mov ah, 1
    int 21h
    sub al, 48

    mov ah, 0
    mov bl, 10
    mul bl
    mov cl, al

    mov ah, 1
    int 21h
    sub al, 48
    add cl, al

    done_b:
    mov b, cl
    ; }

    ; sum operation
    mov al, a
    sub al, b
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
