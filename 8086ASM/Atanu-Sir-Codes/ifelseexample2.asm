; if (a>=b && b<c) then print 'Y' else print 'N'

.model small
.stack 100h

.DATA
a db 23
b db 3
c db 10

.code
main proc
    mov ax, @data
    mov ds, ax 
    
    mov    al, a     ; set al to a. 
    mov    bl, b     ; set bl to b.
    mov    ah, c     ; set ah to c. 
    mov    cl,1      ;assume true
    
    cmp     al, bl      
    jge     greater      ; jump if al >= bl  
    
          
    jmp    stop       
    
    greater:         ; if gets here, 
    cmp    bl, ah    
    jl Okay          ; jump if bl<ah
        
    jmp    stop        
    
    stop:
    mov    dl,78
    mov    ah,2
    INT    21H 
    jmp    exit
    
    okay:
    mov    dl,89
    mov    ah,2
    INT    21H  
    
    exit:
    
MAIN ENDP
END MAIN