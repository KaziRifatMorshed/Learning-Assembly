# Notes of 8086

| Right                                                                                                                                                                           | Wrong                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| ; print new line<br>    mov dl, 10 ; new line only <br>	; but cursor not first<br>    mov ah, 2<br>    int 21h<br>    mov dl, 13 ; cursor first<br>    mov ah, 2<br>    int 21h | ; print new line<br>    mov dl, 13<br>    mov ah, 2<br>    int 21h<br>    mov dl, 10<br>    mov ah, 2<br>    int 21h |
- `mov dl, offset msg1` DO NOT FORGET OFFSET
- `mov ah, 9` DO NOT FORGET `09h`
-  গুণ ভাগ করার আগে AH জিরো করো 
```asm
    MOV ah,0 ; clear AH to use for reminder
    MOV BL,10
    DIV BL  
    mov rem,ah
```
