.model small
.stack 100h
; Check if a triangle has all equal sides or two equal or none
; DONE

.data
m1 db 'all equal$'
m2 db 'two equal$'
m2 db 'none$'
a dw 4
b dw 4
c dw 4

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, a
    mov bx, b
    mov cx, c

a_b_c:
    cmp ax, bx        ; compare a and b
    jne two_equal     ; if not equal, check for two equal
    cmp bx, cx        ; compare b and c
    jne two_equal     ; if not equal, check for two equal
    lea dx, m1        ; all sides are equal
    jmp display
two_equal:
    cmp ax, bx        ; check a=b
    je print_two
    cmp ax, cx        ; check a=c
    je print_two
    cmp bx, cx        ; check b=c
    je print_two
    ; none case
    lea dx, m3        ; no sides equal
    jmp display
print_two:
    lea dx, m2        ; two sides equal
display:
    mov ah, 09h
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main
