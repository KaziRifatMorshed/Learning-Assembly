.model small
.stack 100h
; CASE; print either even or odd
.code ;  DONE
main proc
    mov ah, 1
    int 21h
    mov bl, al
    ;sub bl, '0' ; UNNECESSARY and ERRORNUS

    cmp bl, '1'
    je print_o
    cmp bl, '3'
    je print_o

    cmp bl, '2'
    je print_e
    cmp bl, '4'
    je print_e

    print_o:
    mov dl, 'o'
    jmp print
    print_e:
    mov dl, 'e'
    jmp print
    print:
    mov ah, 2
    int 21h
    jmp end

    end:
    mov ax, 4c00h
    int 21h
main endp
end main ; WORKS
