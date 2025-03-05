; Write an assembly program to add two 16-bit numbers stored in memory and store the result in AX.
; If 1234H and 5678H are added, the result should be 68ACH.
; If there is a carry, store it in DX.
.MODEL SMALL
.STACK 100H

.DATA
NUM1 DW 1234H   ; First number
NUM2 DW 5678H   ; Second number

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, NUM1    ; Load first number into AX
    ADD AX, NUM2    ; Add second number
    JNC NO_CARRY    ; Jump if no carry
    MOV DX, 1       ; Store 1 in DX if carry occurred

NO_CARRY:
    MOV AH, 4CH     ; DOS exit
    INT 21H

MAIN ENDP
END MAIN
