.model small
.stack 100h
.data  
    arr db 60 dup('$')
    inp db "Enter the numbers : $"
    end_ db 10, 13, '$'
.code
main proc  
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, inp
    mov ah, 9
    int 21h
    
    lea di, arr
    mov cx, 0 
    
        mov ah, 1
    input:
        
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