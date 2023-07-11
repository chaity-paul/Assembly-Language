.model small
.data
string1 db 100 dup('$')
inp db 'Enter a string : $' 
newline db 10, 13, '$'
.code
main proc
    mov ax, @data
    mov es, ax
    mov ds, ax 
    
    mov ah, 9
    lea dx, inp
    int 21h 
    
    lea dx, newline
    int 21h
    
    lea di, string1
    call read_str
    
    ;mov ah, 9
    lea dx, newline
    int 21h   
    
    ;lea dx, string1
    ;int 21h 
    
    lea dx, newline
    int 21h
    
    lea si, string1
    call case_conversion
    
    mov ah, 4ch
    int 21h
    
main endp

read_str proc
    push ax
    push di
    
    mov ah, 1
    int 21h
    mov bx, 0
    
    check:
        cmp al, 13
        je final_work
        
        cmp al, 08
        je backspace_work
        
        stosb
        inc bx
        jmp read
        
   backspace_work:
        dec bx
        dec di
        jmp read
        
   read:
        int 21h
        jmp check
        
   final_work:
        mov al, '$'
        stosb
        pop di
        pop ax
        ret
read_str endp 
case_conversion proc
    ; si er majhe amader sitring er initial offset ase
    ; bx er majhe ase je kotogula character ase
    
    push ax
    push dx
    push cx
    push si
    
    
    checker:
           cmp bx, 0
           je sesh_kor
           dec bx 
           lodsb
           check_capital:
                cmp al, 'A'
                jge add_block
           check_small:
                cmp al, 'a'
                jge sub_block
           print:
                mov dl, al
                mov ah, 2
                int 21h
                jmp checker
           add_block:
                cmp al, 'Z'
                jg check_small
                add al, 32
                jmp print
           sub_block:
                cmp al, 'z'
                jg print
                sub al, 32
                jmp print
    sesh_kor:
        pop si
        pop cx
        pop dx
        pop ax
        ret
case_conversion endp
        
end main
        