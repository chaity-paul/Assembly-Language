include "emu8086.inc"
.model small

.stack 100h

.data
inp db 100 dup(?)
vowels db 'aeiou'
consonants db 'bcdfghjklmnpqrstvwxyz'
vow_count dw 0
cons_count dw 0

.code

main proc 
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    printn "Enter the string : "
    
    lea di, inp
    
    call read_str
    
    printn ''
    
    mov si, di
    lea si, inp
    cld
    
    repeat:
        lodsb
        lea di, vowels
        mov cx, 5
        repne scasb
        jne ck_const
        inc vow_count
        jmp untill
    
    ck_const:
        lea di, consonants
        mov cx, 21
        repne scasb
        jne untill
        inc cons_count
    
    untill:
        dec bx
        jne repeat
    
    print "Vowels : "
    
    mov dx, vow_count
    add dl, 48
    mov ah, 2
    int 21h            
    
    printn ''
    
    mov ah, 4ch
    int 21h
    
main endp

read_str proc
    push ax
    push di
    
    cld
    
    mov bx, 0
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

end main