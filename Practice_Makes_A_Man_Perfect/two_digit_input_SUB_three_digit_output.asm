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
text3 db 10, 13, "SUB is = $"
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
        ; input first character
        mov ah, 1
        int 21h
        sub al, 48 ; make it a value
        mov cl, al ; store to temp storage

        mov ah, 1
        int 21h
        cmp al, 13 ; check whether enter was pressed
        je done_a
        ; there is second number in AL; need to move it to safe place and multiply first one
        sub al, 48
        mov bh, al

        mov ah, 0
        mov al, cl
        mov bl, 10
        mul bl
        mov cl, bh ; cl(temp) ke 10 gun kore update korbo

        ;process last input
        add cl, al

        done_a:
        mov a, cl ; final target: CL(temp) to variable_a
    ; }

    prompt2:
    lea dx, text2
    mov ah, 9
    int 21h

    input_b: ; {
        ; NOTE: result will be saved in CL
        mov ah, 1
        int 21h ; take first digit input
        sub al, 48
        mov cl, al ; save first digit in result

        mov ah, 1
        int 21h ; take second input
        cmp al, 13 ; checking
        je done_b

        sub al, 48 ; 2nd input is number; subtract it
        mov bh, al ; store 2nd digit in BH ; so that we may not lost it
        mov al, cl ; move first digit to AL so that we may multiply it
        mov bl, 10
        mov ah, 0 ; extra safety
        mul bl
        mov cl, al ; move multiplication output to CL(result)
        add cl, bh ; add second inputted (previously stored in BH) digit in CL(result)

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
