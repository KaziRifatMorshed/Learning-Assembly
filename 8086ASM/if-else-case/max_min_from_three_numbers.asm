.MODEL SMALL
.STACK 100H

; DONE

.DATA
a dw 33
b dw -36
c dw -99

.CODE

muilti_output proc ; LIMITATION: just can print unsigned number
    ; Store in AX
    mov bx, 10
    mov cx, 0

    cmp ax, 0
    je end_printing

    checking:
    cmp ax, 0
    je start_printing
    mov dx, 0
    div bx
    push dx
    inc cx ; counter
    jmp checking

    start_printing:
    pop dx
    mov ah, 2
    add dx, '0'
    int 21h
    dec cx
    cmp cx, 0
    je end_printing
    jg start_printing

    end_printing:
    ret
muilti_output endp ;  WORKING

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    check_a_b:
    mov ax, a
    cmp ax, b
    jge check_a_c
    jmp check_b_c

    check_a_c:
    mov ax, a
    cmp ax, c
    jge print_a
    jmp print_c

    check_b_c:
    mov ax, b
    cmp ax, c
    jge print_b
    jmp print_c

    print_a:
    mov ax, a
    jmp end
    print_b:
    mov ax, b
    jmp end
    print_c:
    mov ax, c
    jmp end

    end:
    call muilti_output
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
