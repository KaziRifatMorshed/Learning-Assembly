.model small
.stack 100h
; if 'Y' or 'y' is inputted, it will be printer
.code ; DONE
main proc
    ;input a char
    mov ah, 1
    int 21h
    mov bl, al

    cmp bl, 'Y'
    je print_char ; JMP na, JE use korbo
    cmp bl, 'y'
    je print_char ; JMP na, JE use korbo
    jmp end

    print_char:
    mov dl, bl
    mov ah, 2
    int 21h


    end:
    mov ax, 4c00h
    int 21h

main endp
end main ; DONE
