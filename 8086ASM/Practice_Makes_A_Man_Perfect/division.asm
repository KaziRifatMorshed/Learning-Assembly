.model small
.stack 100h

.data
newline db 10, 13, "$"

.code
main proc
   mov ax, @data
   mov ds, ax

   mov ah, 1
   int 21h
   sub al, 48
   mov bh, al

   lea dx, newline
   mov ah, 9
   int 21h

   mov ah, 1
   int 21h
   sub al, 48
   mov bl, al


   lea dx, newline
   mov ah, 9
   int 21h

   mov ah, 0
   mov al, bh
   div bl


   mov dl, al
   add dl, 48

   mov ah, 2
   int 21h

   mov ax, 4c00h
   int 21h
main endp
end main
