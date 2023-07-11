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
    
    mov ah, 4ch
    int 21h
    
main endp

read_str proc
    
    push ax
    push di
    
    mov ah, 1
    int 21h
    
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
        cmp cx, 0
        je sesh
        
        mov di, pattern_offset
        mov si, text_offset
        mov cx, pattern_len
        repe cmpsb
        je sesh_
        inc text_offset
        dec bx  
        dec cx
        jmp loop_one
        sesh:
        printn "Pattern not found"
        ret
        sesh_:
           lea dx, pattern
           mov ah, 9
           int 21h
           print " is a substring of "  
           
           lea dx, text
           int 21h
           ret   
pattern_matching endp    
    
end main        