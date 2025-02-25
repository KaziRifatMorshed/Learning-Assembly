# Notes of 8086

| Right                                                                                                                                                                           | Wrong                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| ; print new line<br>    mov dl, 10 ; new line only <br>	; but cursor not first<br>    mov ah, 2<br>    int 21h<br>    mov dl, 13 ; cursor first<br>    mov ah, 2<br>    int 21h | ; print new line<br>    mov dl, 13<br>    mov ah, 2<br>    int 21h<br>    mov dl, 10<br>    mov ah, 2<br>    int 21h |
- `lea dx, msg1` Load Effective Address
- `mov dl, offset msg1` DO NOT FORGET OFFSET
- `mov ah, 9` DO NOT FORGET `09h`
-  গুণ ভাগ করার আগে AH জিরো করো 
```8086asm
    MOV ah,0 ; clear AH to use for reminder
    MOV BL,10
    DIV BL  
    mov rem,ah
    mov result, al
```
- `sub al, 20h` ; user input will be saved in AL ; subtract `20h` to get lower case
- Shortcut
```asm8086
.data
lf equ 10 ; Line Feed
cr equ 13 ; A carriage return (CR) is a key on a keyboard that moves the cursor to the start of a new line
msg1 db "Enter a lower case letter: $"
msg2 db 10, 13, "In Upper Case Letter, it is : "
char db ?, "$"
```

---
# Perfect Codes
```asm
.model small
.stack 100h

.data
a db 2
b db 3
sum db ?
text1 db "input a : $"
text2 db "input b : $"
text3 db "SUM is = $"

.code
main proc
    mov ax, @data
    mov ds, ax

    ;promot 1
    lea dx, text1
    mov ah, 9
    int 21h

    ; input a
    mov ah, 1
    int 21h
    sub al, 48
    mov a, al

    ; prompt 2
    lea dx, text2
    mov ah, 9
    int 21h

    ; input b
    mov ax, 0 ; extra cure
    mov ah, 1
    int 21h
    sub al, 48
    mov b, al

    ; print new line again
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h

    ; sum operation
    mov al, a
    add al, b
    mov sum, al

    ; print new line
    mov dl, 10
    mov ah, 2
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h

    ; print text3
    lea dx, text3
    mov ah, 9
    int 21h

    ; print operation
    mov dl, sum
    add dl, 48 ; --------- ASCII ----- vule gesilam
    mov ah, 2
    int 21h

    mov ax, 4300h
    int 21h
main endp
end main

```

```asm8086
.model small
.stack 100h

.data
lf equ 10
cr equ 13
msg1 db "Enter a lower case letter: $"
msg2 db 10, 13, "In Upper Case Letter, it is : "
char db ?, "$"

.code
main proc
    ; init DS
    mov ax, @data
    mov ds, ax

    ; first prompt
    lea dx, msg1
    mov ah, 9
    int 21h

    ; user input
    mov ah, 1
    int 21h
    sub al, 20h ; user input will be saved in AL ; subtract 20h to get lower case
    ;mov bl, al ; USELESS
    mov char, al

    ; print CHAR
    lea dx, msg2
    mov ah, 9
    int 21h

    ; exit to DOS
    mov ax, 4c00h
    int 21h
main endp
end main

```