.model small
.stack 100h  

.data 
inp db 'Enter the numbers : $'
arr db 60 dup(?)
end_ db 10, 13, '$'
n db 0

.code
    main proc

         mov ax, @data
         mov ds, ax
         mov es, ax
         
         
         lea dx, inp
         mov ah, 9          
         int 21h
         
         lea di, arr 
         mov ah, 1
         input:
             int 21h
             mov bl, al
             cmp al, 13
             je find_leargest
             mov al, bl
             stosb
             inc n
             jmp input
         find_leargest: 
            
            mov dl, 0
            mov  cx, 0
            mov cl, n
            
            lea si, arr
            
            ghuri:
                lodsb
                mov bl, al
                cmp al, dl
                jg set
                back:
                
                loop ghuri  
             print: 
                mov bl, dl
                lea dx, end_
                mov ah, 9
                int 21h
               
               mov dl, bl 
               mov ah, 2
               int 21h
               
               mov ah, 4ch
               int 21h
             set:
                mov dl, bl
                jmp back
            
            
         
         
    main endp     