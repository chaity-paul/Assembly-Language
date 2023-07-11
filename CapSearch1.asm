.model small
.data
 nl db 10, 13, '$'
 arr db 100, ?, 100 dup('$') 
  v db 0
  c db 0
  s db 0
    
  vv db "aeiouAEIOU$"       
  con db "numver of consonent: $"
  cc db "qwrtypsdfghjklzxcvbnmQWRTYPSDFGHJKLZXCVBNM$" 
  vow db "The number of vowels: $"
 .code 
 
 main proc 
    mov ax, @data
    mov ds, ax
    mov es , ax
    
    lea dx, arr
    mov ah, 10
    int 21h  
    
    lea dx, nl
    mov ah, 9
    int 21h
    
    
    mov si, offset arr + 2
      
    ;mov dx, offset arr + 2
    ;mov ah, 9
    ;int 21h
    
    check:
        lodsb
        
        cmp al, '$'
        je complete 
        ;eta ki vowel kina
        mov cx, 10  
        lea di, vv
        repnz scasb
        je iv
        
        mov cx, 42
        lea di, cc
        repnz scasb
        je ic
              
        
        jmp check
        
            
        
        iv:
            inc v
            jmp check
        ic:
            inc c
            jmp check
         
        complete: 
        
           
           lea dx, con
           mov ah, 9
           int 21h
           
            mov dl, c
            add dl, '0'
            mov ah, 2
            int 21h
              
            lea dx, nl
            mov ah, 9
            int 21h  
            
            
            lea dx, vow
            mov ah, 9
            int 21h
            
            mov dl, v
            add dl, '0'
            mov ah, 2
            int 21h
            
            mov ah, 4ch
            int 21h
   
    
    main endp
 end