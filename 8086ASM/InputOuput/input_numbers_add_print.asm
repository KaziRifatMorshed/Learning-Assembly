.MODEL SMALL
.STACK 100H

.DATA
msg1 DB "Enter number 1: $"
msg2 DB 10, 13, "Enter number 2: $"
msg3 DB 10, 13, "SUM : $"
num1 DB 0
num2 DB 0
mySum DB 0
rem DW 0


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; PRINT MSG 1
    ;MOV DX, OFFSET msg1
    lea dX, msg1
    MOV AH, 9
    INT 21H

    ; READ INPUT NUM1
    MOV AH, 1
    INT 21H ; GET INPUT
    SUB AL, 48 ; the input from the keyboard gets saved in the AL register
    MOV num1, AL ; SAVE VALUE IN RAM

    ; PRINT msg2
    ;MOV DX, OFFSET msg2
    lea dx, msg2
    MOV AH, 9
    INT 21H

    ; READ INPUT 2
    MOV AH, 1 ;; // 1 input, 2 output, 9 string
    INT 21H
    SUB AL, 48
    MOV num2, AL

    ; PRINT MSG3
    ;MOV DX, OFFSET msg3
    lea dx, msg3
    MOV AH, 9
    INT 21H

    ; ADD TWO NUMBERS
    MOV AL, num1 ; Use AL for 8-bit addition
    ADD AL, num2
    MOV mySum, AL ; Store the 16bit result in mysum

    ; PRINT NUMBERs
    MOV AH, 0
    MOV Al, mySum
    MOV BL, 10 ; divisor
    DIV BL

    mov bh, ah
    mov dl, al

    add dl, 48
    mov ah, 2
    int 21h

    mov dl, bh
    add dl, 48
    int 21h

    exit:
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
