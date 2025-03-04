.MODEL SMALL
.STACK 100H

.DATA
A DW 7
B DW 5
SUM DW ? ;; 12
REM DB ? ;; define byte --------------!!!!!!!!!!

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;; CALCULATE SUM
    MOV AX, A
    ADD AX, B
    MOV SUM, AX ;; SUM RESULT WILL BE HERE

    ;; PROCESSING LEFTMOST DIGIT
    MOV AH, 0 ;; CLEAR AH (HIGH-AX) BEFORE DIVISION
    MOV BL, 10 ;; LOAD DIVISOR (10) INTO BL
    DIV BL
    MOV REM, AH ;; ah keno rem e nilam ? keno AL na ???
    ;; MOV REM, BL ;; BL HOBE NA -------------------------------- !!!!

    ;; PRINT TEN'S PLACE DIGIT
    MOV DL, AL ;; ----------------------------- !!!!!!!!!!
    ADD DL, 48
    MOV AH, 2
    INT 21H

    ;; PRINT ONE'S PLACE DIGIT
    MOV DL, REM ;; PRINT KORAR JONNO D er LOW KE KAJE LAGBE
    ADD DL, 48
    MOV AH, 2 ;; AX NA, AH HOBE ------------------------------ !!!!!
    INT 21H

    MOV AX, 4C00H
    INT 21H
MAIN ENDP
END MAIN
