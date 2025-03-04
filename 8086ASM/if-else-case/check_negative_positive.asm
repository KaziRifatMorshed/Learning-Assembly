.MODEL SMALL
.STACK 100H
.DATA
    msg1 DB 'Enter a number: $'
    pos_msg DB 'The number is Positive$'
    neg_msg DB 'The number is Negative$'
    newline DB 0DH,0AH,'$'
    num1 db ?
    num2 dw ?

.code
main proc

    mov ax, @data
    mov ds, ax


    mov ax, 4c00h
    int 21h
main endp
end main
