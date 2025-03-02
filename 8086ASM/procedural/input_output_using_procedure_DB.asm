.model small
.stack 100h
; WORKS
.data
msg1 db "input a number : $"
msg2 db 10, 13, "you inputted : $"
user_input db ?

.code
print_line_proc proc
    mov ah, 9
    int 21h
    ret
print_line_proc endp

print_char_proc proc
    mov ah, 2
    int 21h
    ret
print_char_proc endp

get_user_input proc
    mov ah, 1
    int 21h
    ret
get_user_input endp

main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    call print_line_proc
    call get_user_input
    mov user_input, al

    lea dx, msg2
    call print_line_proc
    mov dl, user_input
    call print_char_proc

    ending:
    mov ax, 4c00h
    int 21h
main endp
end main
