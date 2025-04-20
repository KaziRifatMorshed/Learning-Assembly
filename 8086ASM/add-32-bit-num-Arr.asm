.MODEL SMALL
.STACK 100h
.DATA
    len dw 11
    num1 dw 11 dup(0)
    num2 dw 11 dup(0)

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 9
    LEA DX, message
    INT 21h

    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
