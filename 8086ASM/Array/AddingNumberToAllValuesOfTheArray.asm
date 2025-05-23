; Simple 8086 assembly program
.model small
.stack 100h

; Adding a number to all values of the array
.data
arr dw 1,2,3,4,5,6
len dw 6
new_line db 10, 13, "$"   ; Changed from 'dw' to 'db' since these are character values
; DW দিলে একটা করে স্পেস প্রিন্ট হচ্ছিলো

; DONE

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, arr

    mov cx, len
    add_to_all:
        mov ax, [si]
        add ax, 2
        mov [si], ax
        add si, 2    ; Changed from 1 to 2 since we're working with words (2 bytes)
        loop add_to_all

    mov cx, len
    lea si, arr

    print_Loop:
        mov dx, [si]
        add dx, '0'      ; This will only work properly if values are 0-9
        mov ah, 2
        int 21h
        add si, 2        ; Added increment to move to next array element

        lea dx, new_line
        mov ah, 9
        int 21h

        loop print_Loop

    ; Return to DOS
    mov ax, 4C00h
    int 21h
main endp
end main
