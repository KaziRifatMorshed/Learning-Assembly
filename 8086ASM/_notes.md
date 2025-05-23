# Notes of 8086

| Right                                                                                                                                                                           | Wrong                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| ; print new line<br>    mov dl, 10 ; new line only <br>	; but cursor not first<br>    mov ah, 2<br>    int 21h<br>    mov dl, 13 ; cursor first<br>    mov ah, 2<br>    int 21h | ; print new line<br>    mov dl, 13<br>    mov ah, 2<br>    int 21h<br>    mov dl, 10<br>    mov ah, 2<br>    int 21h |
- `lea dx, msg1` Load Effective Address (note: it is not `DL` or `DH`, it WILL BE `DX`)
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
```asm
.data
lf equ 10 ; Line Feed
cr equ 13 ; A carriage return (CR) is a key on a keyboard that moves the cursor to the start of a new line
msg1 db "Enter a lower case letter: $"
msg2 db 10, 13, "In Upper Case Letter, it is : "
char db ?, "$"
```
- Double or Single digit input:
```asm
    input_b: ; {
        ; NOTE: result will be saved in CL
        mov ah, 1
        int 21h ; take first digit input
        sub al, 48
        mov cl, al ; save first digit in result

        mov ah, 1
        int 21h ; take second input
        cmp al, 13 ; checking
        je done_b

        sub al, 48 ; 2nd input is number; subtract it
        mov bh, al ; store 2nd digit in BH ; so that we may not lost it
        mov al, cl ; move first digit to AL so that we may multiply it
        mov bl, 10
        mov ah, 0 ; extra safety
        mul bl
        mov cl, al ; move multiplication output to CL(result)
        add cl, bh ; add second inputted (previously stored in BH) digit in CL(result)

        done_b:
        mov b, cl
    ; }
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

```asm
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

```asm
    cmp ax, 13 // DOES NOT WORK
    cmp al, 13
```

---

## `and ax, 1` Technical effect

Since 1 in binary is 00000000 00000001:
- Only the least significant bit (LSB) of AX will be preserved
- All other bits will be set to 0

## `and ax, 1` Common uses

1. **Checking if a number is odd or even**
   - If result is 1, the original number was odd
   - If result is 0, the original number was even

2. **Isolating the LSB**
   - Removes all other bits, keeping only the rightmost bit

3. **Boolean conversion**
   - Converts any non-zero value with LSB=1 to exactly 1
   - Maintains 0 as 0

---
