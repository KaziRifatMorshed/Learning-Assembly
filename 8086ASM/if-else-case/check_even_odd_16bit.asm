.model small
.stack 100h

; 16 BIT DW
;

.data
a dB ?
msg1 db "Input a number: $"
msg_even db 10, 13, "Even Number$"
msg_odd db 10, 13, "Odd Number$"



main proc
    mov ax, @data
    mov ds, ax

    InputPrompt:
    lea dx, msg1
    mov ah, 9
    int 21h

    take_input:
    call ???????????????????
    sub al, '0'
    mov a, al

    processing:
    mov ah, 0
    mov bl, 2
    div bl

    checking:
    cmp ah, 1
    je print_odd
    jne print_even

    print_even:
    lea dx, msg_even
    mov ah, 9
    int 21h
    jmp end

    print_odd:
    lea dx, msg_odd
    mov ah, 9
    int 21h
    jmp end

    end:
    mov ax, 4c00h
    int 21h
main endp
end main
