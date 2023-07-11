.model small
.stack 100h  

.data 
inp db 'Enter a number : $'
end_ db 10, 13, '$'

.code
    main proc

         mov ax, @data
         mov ds, ax
         
         lea dx, inp
         mov ah, 9
         int 21h
         
         mov ah, 1
         int 21h 
         
         cmp al, '0'
         je display
          
         mov cx, 0
         mov cl, al
         sub cl, '0'
         mov ax, 0
         mov al, 1
         mov bx, 0
         mov bl, 1
        
         fact:
            mul bl
            inc bl
            loop fact 
         
         mov bl, al
         
         lea dx, end_
         mov ah, 9
         int 21h 
         
         mov dl, bl
         add dl, '0'
         mov ah, 2
         int 21h
         jmp endp_
         
         display:
            lea dx, end_
            mov ah, 9
            int 21h  
            
            mov ah, 2
            mov dl, '1'
            int 21h 
         endp_:
           
         mov ah, 4ch
         int 21h
    
    main endp