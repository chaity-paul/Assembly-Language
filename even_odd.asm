.model small
.stack 100h 

.data 
inp db 'Enter a number : $' 
ev db 'The number is even ...$'
od db 'The number is odd ...$'
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
        
        mov ah, 0
        mov bl, 2
        
        div bl 
        cmp ah, 0
        je even
        jne odd
        
        even:
            lea dx, end_
            mov ah, 9
            int 21h
        
            lea dx, ev
            mov ah, 9
            int 21h 
        jmp exit_    
        
        odd:
            lea dx, end_
            mov ah, 9
            int 21h
        
            lea dx, od
            mov ah, 9
            int 21h
        
        exit_:        
    main endp
