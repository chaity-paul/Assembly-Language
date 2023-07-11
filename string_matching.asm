include "emu8086.inc"

.model small

.stack 100h

.data
    inp db 100 dup(?)
    len dw ?
    text db 100 dup (?)
    text_len dw ?
    text_offset dw ?
    
    pattern db 100 dup(?)
    pattern_len dw ?
    pattern_offset dw ?
    
.code

main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    printn "Enter the text string: "
    
    lea di , text
    mov text_offset, di
    call read_str
    mov text_len, bx
    
    printn ''
    
    printn "Enter the pattern: "
    lea di, pattern
    mov pattern_offset , di
    call read_str
    mov pattern_len, bx
    
    printn ''
    call pattern_matching
    
   
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

pattern_matching proc    
    mov bx, text_len
    cld
    
    loop_one:
        cmp bx, 0
        je sesh
        
        mov di, pattern_offset
        mov si, text_offset
        mov cx, pattern_len
        repe cmpsb
        je sesh_
        inc text_offset
        dec bx
        jmp loop_one
        sesh:
        printn "Pattern not found"
        ret
        sesh_:
           printn "Pattern is found"
           ret   
   
pattern_matching endp

end main