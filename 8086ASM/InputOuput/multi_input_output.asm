.model small
.stack 100h

; WORKING
; multiple value input and multiple value output

.data
m1 db "Enter a number : $"
m2 db 10, 13, "You entered : $"
whole_num dw 0
new_single dw 0
input_num dw 43210

.code

multi_input proc
; need two tempo storage
; one for whole number (CX)
; another for newly_inputted digit (DX)

    mov cx, 0 ; safety
    take_an_input:
    mov ah, 1
    int 21h

    ; checking
    cmp al, 13
    je get_out ; if

    ;else :
    sub al, '0' ; ascii to decimal conversion
    mov ah, 0 ; for 16 bit operation
    mov new_single, ax ; tempo storation of newly_inputted number so that i can process previous digits
    mov bx, 10 ; for sake of multiplication
    mov ah, 0
    mov ax, whole_num ; full num storing tempo theke AL e nilam
    mul bx
    ; AX stores multiplication result
    add ax, new_single ; add newly inputted part to whole number
    mov whole_num, ax ; store again in Whole Number Tempo
    jmp take_an_input

    get_out:
    mov ax, whole_num
    mov input_num, ax
        ret
multi_input endp ; WORKING



muilti_output proc ; UN-SIGNED NUMBER
    ; STORE value to AX
    mov ax, 4300
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

main proc
    mov ax, @data
    mov ds, ax

    ;call multi_input
    call muilti_output

    mov ax, 4c00h
    int 21h
main endp
end main

; ----------------------------------------
;
; take_multi_input proc
;    push bx
;    push cx
;    push dx

;    mov bx, 0      ; Initialize result
;    mov cx, 0      ; Initialize sign flag

;    read_digit:
;        mov ah, 1  ; Read claracter
;        int 21h

;        cmp al, 13 ; cleck for Enter key
;        je done_reading

;        sub al, '0'    ; Convert ASCII to number
;        mov ah, 0      ; Clear AH
;        push ax        ; Save digit

;        mov ax, bx     ; Multiply previous result by 10
;        mul ten        ; AX = AX * 10
;        mov bx, ax     ; Store back in BX

;        pop ax         ; Restore digit
;        add bx, ax     ; Add digit to result

;        jmp read_digit

;    done_reading:
;        mov ax, bx     ; Put result in AX

;    pop dx
;    pop cx
;    pop bx
;    ret
;take_multi_input endp
