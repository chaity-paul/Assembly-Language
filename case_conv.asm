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
    
    call case_conv
    
    lea dx, inp
    mov ah, 9
    int 21h
    
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

case_conv proc 
    ; si and di will indicate the same position
    ; we will load the data to al
    ; do the change
    ; then store it back using di
    ; we know we need to do it bx time
    ; we will use cx as counter
    
    push cx
    push ax
    mov cx, bx
    cld
    
    work:
        lodsb
        call do_change
        stosb
    loop work
    
    pop ax
    pop cx
    ret
    
    
case_conv endp

do_change proc
    cmp al, 'A'
    jl end_
    
    cmp al, 'Z'
    jle conv
    
    cmp al, 'a'
    jl end_
    
    cmp al, 'z'
    jle conv   
    
    jmp end_
 
    conv:
        xor al, 20h
        jmp end_
    end_:
        ret 
    
        
do_change endp

end main