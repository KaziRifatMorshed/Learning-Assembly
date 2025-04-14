.MODEL SMALL
.STACK 100h

.DATA
    text DB "abcdef$"    ; Changed to DB (byte) instead of DW
    len DW 6             ; Length is 6 characters (not including $)

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Set up source pointer at beginning of string
    LEA SI, text

    ; Set up destination pointer at end of string (last character)
    LEA DI, text
    ADD DI, len
    DEC DI              ; Point to last character (not $)

    ; Initialize counter
    MOV CX, len
    SHR CX, 1           ; Divide by 2, we only need to swap half the array

    ; Reverse the array by swapping characters
REVERSE_LOOP:
    ; Get characters from both ends
    MOV AL, [SI]        ; Get character from beginning
    MOV BL, [DI]        ; Get character from end

    ; Swap the characters
    MOV [SI], BL
    MOV [DI], AL

    ; Move pointers
    INC SI
    DEC DI

    ; Loop until done
    LOOP REVERSE_LOOP

    ; Display the reversed string
    LEA DX, text
    MOV AH, 9
    INT 21h

    ; Exit program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
