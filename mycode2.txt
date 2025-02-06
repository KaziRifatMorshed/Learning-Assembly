.MODEL SMALL
.STACK 100H

.DATA
    A DW 7
    B DW 5
    SUM DW ?
    rem DB ?
    
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS,AX
    
    MOV AX,A
    ADD AX,B
    MOV SUM,AX
    
    MOV ah,0
    MOV BL,10
    DIV BL  
    mov rem,ah
    
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    mov dl,rem
    add dl,48
    mov ah,2
    int 21h
    
    
    MOV AX,4C00H 
    INT 21H
    
MAIN ENDP

END MAIN