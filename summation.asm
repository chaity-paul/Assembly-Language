.model small 
.stack 100h 

.data 
 msg db 'chaity!!$'
 end_ db 10, 13, '$'
 inp db 'Enter a number : $' 
 
.code
    main proc 
        
        mov ax, @data
        mov ds, ax
        
        lea dx, inp
        mov ah, 9
        int 21h
        
        mov ah, 1
        int 21h 
        
        mov cx, 0
        mov cl, al
        sub cl, '0' 
        mov bx, 0
        mov bl, 1
        mov al, 0
        
        sum:
            add al, bl
            inc bl
            loop sum  
        mov bl, al
            
        lea dx, end_
        mov ah, 9
        int 21h    
        
        add bl, '0'
        mov dl,bl 
        
        mov ah, 2
        int 21h    
        
        mov ah, 4ch
        int 21h

        
        
    main endp
