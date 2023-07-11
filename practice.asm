include "emu8086.inc"

.code
    
    printn "Enter the number : "
    
    mov ah, 1
    int 21h  
    
    sub al, '0'
    
    mov ah, 0
    mov cx, ax
    mov ax, 0
    
    work_:
        add ax, cx
    loop work_  
    
    printn ''
    
    mov dl, al 
    add dl, '0'
    mov ah, 2
    int 21h   
