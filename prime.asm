.model small
.stack 100h 

.data 
inp db 'Enter a number : $' 
pr db 'The number is prime ...$'
npr db 'The number is non-prime ...$'
end_ db 10, 13, '$' 
n dw ?

.code

    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, inp
        mov ah, 9
        int 21h
        
        mov ah, 1
        int 21h  
        
        mov ah, 0
        mov ch, 0
        sub al, '0'
        mov n, ax
        mov cx, ax
        sub cx, 2 
        mov dl, 2
        
        cmp ax, 2
        je prime
        jl non_prime
        
        check:
            mov ax, n
            div dl
            cmp ah, 0
            je non_prime
            inc dl
            loop check 
            jmp prime
            
        non_prime:
              lea dx, end_
              mov ah, 9
              int 21h
              
              lea dx, npr
              mov ah, 9
              int 21h 
              jmp exit
       
       prime:
           lea dx, end_
           mov ah, 9
           int 21h
          
           lea dx, pr
           mov ah, 9
           int 21h 
        
       exit: 
       
    mov ah, 4ch
    int 21h    
    
    main endp          