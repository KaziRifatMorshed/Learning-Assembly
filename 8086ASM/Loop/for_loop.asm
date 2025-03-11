; basic loop
; print stars
.model small
.stack 100h
.data

.code
main proc

    mov cx, 5
    mov dx, "*"
    mov ah, 2
    print_star_loop:
    int 21h
    loop print_star_loop

    mov ah, 4ch
    int 21h
main endp
end main ; DONE
