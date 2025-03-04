.model small
.stack 100h

; 8 BIT DB
; DONE

.data
a dB ?
msg1 db "Input a number: $"
msg_even db 10, 13, "Even Number$"
msg_odd db 10, 13, "Odd Number$"

take_single_input proc
    mov ah, 1
    int 21h
    ret ; ------------------- vule gesilam
take_single_input endp


main proc
    mov ax, @data
    mov ds, ax

    InputPrompt:
    lea dx, msg1
    mov ah, 9
    int 21h

    take_input:
    call take_single_input
    sub al, '0'
    mov a, al

    processing:
    mov ah, 0
    mov bl, 2
    div bl

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
