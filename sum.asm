include "emu8086.inc"
.code               

printn "Enter the number :"

mov ah, 1
int 21h

sub al, '0'

; loop calanor jonno amader cx e value rakhte hobe

;input ase al e
;ah e 0 thakte hobe 
mov ah, 0

mov cx, ax

mov ax, 0

le_add:
    add ax, cx
loop le_add
            
printn ''
mov dl, al
add dl, '0'
mov ah, 2
int 21h