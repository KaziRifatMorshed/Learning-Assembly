.model small
.stack 100h

; Search element from arr
; DONE

.data
    p_found db "Found$"
    p_not_found db "Not Found$"
    arr db 11,22,33,44,56,78,89
    len db 7
    key db 33
.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, arr
    mov cl, 0

    ; for
    loop:
        ; if (arr[is] == key) {
        mov al, [si]
        cmp al, key
        je print_found
        ;   print Found
        ; } end if
        inc cx
        add si, 1
        cmp cl, len
        jl loop:
        ; end for
    loop_end:

    ; print not Found
    print_not_found:
        lea dx, p_not_found
        mov ah, 9
        int 21h
        jmp end

    ; print_found
    print_found:
        lea dx, p_found
        mov ah, 09h
        int 21h
        jmp end


    end:
    mov ax, 4C00h
    int 21h
main endp
end main
