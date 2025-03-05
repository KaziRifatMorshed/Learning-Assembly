.MODEL SMALL
.STACK 100H

; DONE

.DATA
    msg1 DB 'Enter a number: $'
    pos_msg DB 'The number is Positive$'
    neg_msg DB 'The number is Negative$'
    newline DB 10, 13, '$'
    num1 dw -13
    num2 dw 13

.code
main proc

    mov ax, @data
    mov ds, ax

    mov ax, num1
    test ax, ax
    jns print_pos ; JNS means "Jump if Not Sign"
    jmp print_neg

    print_pos:
    lea dx, pos_msg
    jmp print
    print_neg:
    lea dx, neg_msg
    jmp print
    print:
    mov ah, 9
    int 21h


    mov ax, 4c00h
    int 21h
main endp
end main
