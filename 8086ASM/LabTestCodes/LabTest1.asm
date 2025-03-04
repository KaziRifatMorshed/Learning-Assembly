; DONE
.model small
.stack 100h

; Question
; 3a + 2b + c
; result could be 2 digits


.data
a db ? ; 2 digit user input
b db ? ; 1 digit user input
c db 1 ; single digit fix value
result db ? ; result
vagfol db ?
vagsesh db ?

msg1 db "input num a : $"
msg2 db 10, 13, "input num b : $"
msg3 db 10, 13, "result is : $"
;msg4 db 10, 13, "input num a : $"




.code
main proc

mov ax, @data
mov ds, ax

; input a
lea dx, msg1
mov ah, 9
int 21h

mov ah, 1
int 21h
sub al, '0'
mov ah, 0
mov bl, 10
mul bl
mov cl, al ; temporarely moving value to CL

mov ah, 1
int 21h
sub al, 48
add cl, al

; store a
mov a, cl

; input b
lea dx, msg2
mov ah, 9
int 21h

mov ah, 1
int 21h
sub al, 48

; store b
mov b, al

; perform operation 3a + 2b + c
; 3a
mov al, a
mov ah, 0
mov bl, 3
mul bl
mov a, al

; 2b
mov al, b
mov ah, 0
mov bl, 2
mul bl
mov b, al

; perform 3a + 2b + c
mov al, a
add al, b
add al, c
mov result, al


print_output:
; raugh ; 23 / 10 = 2 vagfol , 23 % 10 = 3 vagsesh
lea dx, msg3
mov ah, 9
int 21h

mov ah, 0
mov al, result
mov bl, 10
div bl
mov vagfol, al
mov vagsesh, ah

mov dl, vagfol
mov ah, 2
add dl, 48
int 21h
mov dl, vagsesh
mov ah, 2
add dl, 48
int 21h

mov ax, 4c00h
int 21h

main endp
end main
