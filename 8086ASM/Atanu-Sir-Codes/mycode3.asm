.model small
.stack 100h
.data 
    msg1 db "Enter number 1:$"
    msg2 db "Enter number 2:$"
    msg3 db "Sum is:$"
    no1 db 0
    no2 db 0
    mysum db 0
    rem db 0


.code 
    mov ax,@data 
    mov ds,ax

;print msg 1
    mov dx,offset msg1 
    mov ah,09h
    int 21h

;read input no1
    mov ah,01h
    int 21h
    sub al,48
    mov no1,al

;print new line
    mov dl,10
    mov ah,02h
    int 21h

;print msg2
    mov dx,offset msg2
    mov ah,09h
    int 21h

;read input 2
    mov ah,01h
    int 21h
    sub al,48
    mov no2,al

;print new line 
    mov dl,10
    mov ah,02h
    int 21h

;print msg3
    mov dx,offset msg3
    mov ah,09h
    int 21h

;add two numbers
    mov dl,no1
    add dl,no2
    ;moving the sum to mysum
    mov mysum,dl

    ;clear AH to use for reminder
    mov ah,00
    ;moving sum to al
    mov al,mysum
    ;take bl=10
    mov bl,10
    ;al/bl --> twodigit number/10 = decemel value
    div bl
    ;move reminder to rim
    mov rem,ah
    ;to print (al) we move al to dl
    mov dl,al
    add dl,48
    mov ah,02h
    int 21h

    ;to print the reminder
    mov dl,rem
    add dl,48
    mov ah,02h
    int 21h

    mov ax,4c00h
    int 21h
end