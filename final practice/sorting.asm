.model small
.stack 100h
.data 
    inp db 'Enter the numbers : $'
    arr db 60 dup('$')
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
    
    input:
        mov ah, 1
        int 21h
        
        cmp al, 13
        je sort
        
        stosb
        inc cx
        
        jmp input   
        
        
        sort:
            mov al, '$'
            stosb
            
            mov si, 0 
            
                outer:
                
                    mov al, arr[si] 
                    cmp al, '$'
                    je exit
                     
                mov di, si    
                    
                inner:
                    mov al, arr[di]
                    cmp al, '$'
                    je next_inner
                    mov ah, arr[si] 
                    mov al, arr[di] 
                    cmp ah, al
                    jl swap
                    jmp next
                
                swap:
                    mov arr[si], al
                    mov arr[di], ah
                    jmp next
                
                next_inner:
                    inc si
                    jmp outer
                
                next:
                    inc di
                    jmp inner
                    
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
    