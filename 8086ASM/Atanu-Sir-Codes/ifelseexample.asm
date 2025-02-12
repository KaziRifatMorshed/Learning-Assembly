; if a==b then print y else print n

.model small
.stack 100h
.code
main proc  
    mov    al, 25     ; set al to 25. 
    mov    bl, 10     ; set bl to 10. 
    
    cmp    al, bl     ; compare al - bl. 
    
    je     equal      ; jump if al = bl (zf = 1). 
    
    mov    dl,78        ; if it gets here, then al <> bl, 
    jmp    stop       ; so print 'n', and jump to stop. 
    
    equal:            ; if gets here, 
    mov dl,89        ; then al = bl, so print 'y'. 
    
    stop:
    
    mov ah,2
    INT 21H
    
MAIN ENDP
END MAIN