include "emu8086.inc"

.model small

.stack 100h

.data
    inp db 100 dup(?)
    len dw ?
.code

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    printn "Enter the string: "
    
    lea di, inp
    call read_str ; bx will contain the number of character in the string
    mov len, bx
              ; amra jokhon input nibo
              ; al -> ram e jabe
              ; ram will be used as a destination 
    printn ''
    
    lea dx, inp
    mov ah, 9
    int 21h 
    
    printn ''
    
    lea di, inp
    lea si, inp
    mov bx, len
    
    call rev_stack
    
    printn ''
    
    mov ah, 4ch; int21h er 4ch number fuction
                    
    int 21h
    
    
         
main endp      

read_str proc
    ; bx will contain the number of charater
    ; es:di will use to store the data from al to [es:di]
    
    ; we will use cld to .......... make df = 0
    
    ; we will use ax, di
    ; so we will push it
    
    push di
    push ax
    
    cld
    
    mov bx, 0
    mov ah, 1
    int 21h
    
    ; we have taken a character
    
    ; now we need to check the character for enter and backspace
    
    check:
        cmp al, 13
           je enter_block
        cmp al, 8
           je backs_block
        
        stosb
        inc bx 
        jmp read
        
    read:
        int 21h
        jmp check
    
    backs_block:
        dec bx
        dec di
        jmp read
    
    enter_block:
        mov al, '$'
        stosb
        
        pop ax
        pop di
        ret
read_str endp

rev_arr proc
    ; 
    add si, bx
    dec si
    
    mov cx, bx
        std
        
    rep_work:
            lodsb
            ; al e data aslo
            mov dl,al
            mov ah, 2
            int 21h
            
    loop rep_work
    ret
rev_arr endp 

rev_stack proc
    mov cx, bx
    pusher:
        lodsb
        push ax
    loop pusher
    
    mov cx, bx
    mov ah, 2
    poper:
        pop dx
        int 21h
    loop poper
    ret
rev_stack endp

end main