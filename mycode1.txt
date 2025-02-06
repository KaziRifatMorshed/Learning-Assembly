.MODEL SMALL
.STACK 100H

.DATA
    A DW 2
    B DW 3
    SUM DW ?
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS,AX
    
    MOV AX,A
    ADD AX,B
    MOV SUM,AX
    
    MOV DL,AL
    ADD DL,48
    MOV AH,2
    INT 21H
    
    MOV AX,4C00H 
    INT 21H
    
MAIN ENDP

END MAIN