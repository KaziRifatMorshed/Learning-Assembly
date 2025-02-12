.model small
.stack 100h

.code
main proc

    mov al, 25
    mov bl, 16
    ; NEGATIVE WORKS

    cmp al, bl
    je equalBlock
    ; jne notEqualBlock ????

    mov dl, 78
    jmp stopBlock ;;;; I FORGOT THIS LINE, so DL got replaced by 'Y' wharer it was 'N' before

    equalBlock:
    mov dl, 89

    stopBlock:
    mov ah, 2
    int 21h

    mov ax, 4c00h
    int 21h

main endp
end main
