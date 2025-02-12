.MODEL SMALL
.STACK 100H

.DATA
msg1 DB "Enter number 1: $"
msg2 DB "Enter number 2: $"
msg3 DB "SUM : $"
num1 DB 0
num2 DB 0
mySum DW 0
rem DW 0


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; PRINT MSG 1
    MOV DX, OFFSET msg1
    MOV AH, 09H
    INT 21H

    ; READ INPUT NUM1
    MOV AH, 01H
    INT 21H ; GET INPUT
    SUB AL, 48 ; the input from the keyboard gets saved in the AL register
    MOV num1, AL ; SAVE VALUE IN RAM


    ;; PRINT INPUTTED NUMBER1
    XOR DL, DL
    MOV AH, 0
    MOV DL, num1
    ADD DL, 48
    MOV AH, 2
    INT 21H

    ; print new line
    mov dl, 13  ; Carriage return fixes curser to the first line
    mov ah, 2
    int 21h ; moving curser, done
    mov dl, 10  ; Line feed
    mov ah,2
    int 21h

    ; PRINT msg2
    MOV DX, OFFSET msg2
    MOV AH, 09H
    INT 21H

    ; READ INPUT 2
    MOV AH, 1 ;; // 1 input, 2 output, 9 string
    INT 21H
    SUB AL, 48
    MOV num2, AL

    ; print new line
    mov dl, 13  ; Carriage return fixes curser to the first line
    mov ah, 2
    int 21h ; moving curser, done
    mov dl, 10  ; Line feed
    mov ah, 2
    int 21h

    ; PRINT MSG3
    MOV DX, OFFSET msg3
    MOV AH, 9
    INT 21H

    ; ADD TWO NUMBERS
    XOR AX, AX
    MOV AL, num1 ; Use AL for 8-bit addition
    ADD AL, num2
    MOV mySum, AX ; Store the 16bit result in mysum
    ;; CONFUSED, 8-BIT VS 16-BIT

    ; PRINT NUMBERs
    MOV AX, 0
    MOV AX, mySum
    MOV BL, 10 ; divisor
    XOR AH, AH
    XOR DX, DX ; CLEAR DX, IMPORTANT FOR DIVISION
    DIV BL

    ;;; PRINT RIGHT-MOST DIGIT
    MOV AH, 0
    MOV DL, AH
    ADD DL, 48 ; forgot
    MOV AH, 2
    INT 21H

    XOR DL, DL
    MOV DL, rem
    ADD DL, 48
    MOV AH, 2
    INT 21H

    exit:
    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN
;;;;;;; ??????????
