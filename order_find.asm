include "emu8086.inc"

.model small

.stack 100h

.data
    inp db 100 dup(?)
    len dw ?
    start_offset dw ?
    max_len dw ?
    
    tmp_offset dw ?
    tmp_len dw ?
    last db ?
.code

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    printn "Enter the text: "
    
    lea di, inp
    call read_str
    mov len, bx  
    
    
    
    lea si, inp  
    printn ''
    print "The maximum order is: "
    call get_order
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
   
get_order proc
    mov max_len, 0
    mov tmp_len, 0
    mov last, 0
    mov cx, bx 
    
    
    repet:
        mov al, [si] 
        ; al e amader current data cole asbe
        ; check last + 1 == al kina
        inc last
        cmp al, last
        je equal
        ; not equal hoile ki hobe
        mov tmp_len , 1
        mov last, al
        mov tmp_offset, si
        mov dx, tmp_len
        cmp dx, max_len
        jg update
        jmp abar_koro
        
        equal:
            inc tmp_len
            mov dx, tmp_len
            cmp dx, max_len
            jg update
            jmp abar_koro
        update:
            mov max_len, dx
            mov dx, tmp_offset
            mov start_offset, dx
            jmp abar_koro
        abar_koro:
        inc si
        loop repet
   mov si, start_offset
   add si, max_len
   mov [si], '$'
   mov dx, start_offset
   mov ah, 9
   int 21h
   ret
        
        
        
get_order endp

end main