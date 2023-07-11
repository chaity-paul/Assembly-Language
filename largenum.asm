.model small
.stack 100h
.data
    arr db 10 dup('$')
    end_ db 10, 13, '$' 
.code
main proc
     mov ax, @data
     mov ds, ax
     mov es, ax 
     
     lea di, arr
     mov cx, 0
     
     input:
         mov ah, 1
         int 21h
         
         cmp al, 13
         je enda
         stosb
         inc cx
         jmp input
    
    enda:
        mov bl, 0
                 
        lea si, arr 
        check:
            lodsb
            cmp al, bl
            jg change
            admin:
            loop check
        
        lea dx, end_
        mov ah, 9
        int 21h
            
        mov dl, bl
        mov ah, 2
        int 21h        
            
    
    mov ah, 4ch
    int 21h
    
    change:
        mov bl, al 
        jmp admin
main endp          
         