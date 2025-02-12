.model small
.data
myres db ?
rem db 0
.code

    mov ax, @data
    mov ds, ax 

    mov dl, 10  
    mov bl, 0         

    scanNum:

            mov ah, 01h
            int 21h

            cmp al, 13   ; Check if user pressed ENTER KEY
            je  exit 

            mov ah, 0  
            sub al, 48   ; ASCII to DECIMAL

            mov cl, al
            mov al, bl   ; Store the previous value in AL

            mul dl       ; multiply the previous value with 10

            add al, cl   ; previous value + new value ( after previous value is multiplyed with 10 )
            mov bl, al
            mov myres, bl

            jmp scanNum    

    exit:
            ;print new line
            mov dl,10
            mov ah,02h
            int 21h   
            
            ;clear AH to use for reminder
            mov ah,00
            mov dl,0
            mov bl,0
            ;moving sum to al
            mov al,myres
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

           mov ah, 04ch   
           int 21h

end