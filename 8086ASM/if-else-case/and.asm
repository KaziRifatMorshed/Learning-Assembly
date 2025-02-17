.model small
.stack 100h
; read a character, if it is uppercase, print it
.code ; DONE
    main proc

        ; take input
        mov ah, 1
        int 21h
        mov bl, al

        ; if (A <= ch and ch <= Z)
        ; if (ch >= 'A' and ch <= Z)
        ; cmp 'A', bl ; (13) first operand cannot be an immediate value
        cmp bl, 'A'
        jl end
        cmp bl, 'Z'
        jg end

        print_char:
        mov dl, bl
        mov ah, 2
        int 21h

        end:
        mov ax, 4c00h
        int 21h
    main endp
end main
; WORKS
