.model small
.stack 100h  

.data 
inp db 'Enter the numbers : $'
arr db 60 dup('$')
end_ db 10, 13, '$'
n dw 0

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
             je sort
             mov al, bl
             stosb
             inc n
             jmp input
         sort:
            mov al, '$'
            stosb
            
            mov si ,  0
            
            outer:
                mov al, arr[si]
                cmp al, '$'  
                je exit
                
                mov di, si
                
                inner:
                    mov al, arr[di]
                    cmp al, '$'
                    je next_inner
                    
                    mov al, arr[di]
                    mov ah, arr[si]
                    cmp ah, al
                    ; for assending
                    jg swap
                    jmp next
                    
                    swap:
                        mov arr[di], ah
                        mov arr[si], al
                        jmp next
                    next:
                        inc di
                        jmp inner
                 next_inner:
                    inc si
                    jmp outer
              exit:
                lea dx, end_
                mov ah, 9
                int 21h
                
                lea dx, arr
                mov ah, 9
                int 21h
                
                mov ah, 4ch
                int 21h
                
                
            
              
                
              
             
            
           
            
            
         
         
    main endp