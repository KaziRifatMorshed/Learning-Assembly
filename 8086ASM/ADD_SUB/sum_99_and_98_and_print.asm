.model small
.stack 100h

.data
a dw 99
b dw 98
sum dw 0
rem db 0

.code
main proc
mov ax, @data
mov ds, ax

; do sum
mov ax, a
add ax, b ;; now AX holds the sum
mov sum, ax ; store sum

; process first digit
mov bl, 100 ; for sake of division
div bl
mov rem, ah
;;;;;;;;;; mov bh, al ;; TEMPORARELY STORING VAG FOL TO BH
mov dl, al
add dl, 48
mov ah, 2
int 21h ;; first digit print done

; process 2nd digit
;; CAN NOT DO "mov ax, rem"
mov ah, 0
mov al, rem
mov bl, 10
div bl
mov rem, ah
mov dl, al
add dl, 48 ;; FORGOT
mov ah, 2
int 21h

; process last (right-most) digit
mov dl, rem
add dl, 48 ;; FORGOT
mov ah, 2
int 21h

mov ax, 4c00h
int 21h

main endp
end main
;; done
