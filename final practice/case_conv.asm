.model small
.stack 100h
.data   
    inp db "Enter the string : $"
    arr db 100, ?, 100 dup('$')
    nl db 10, 13, '$'
.code

main proc
          
     mov ax, @data
     mov ds, ax
     mov es, ax
     
     lea dx, inp
     mov ah, 9
     int 21h
     
     lea dx, arr
     mov ah, 10
     int 21h
     
     lea dx, nl
     mov ah, 9
     int 21h   
     
     mov cx, 0
     mov cl, arr[1]
     
     mov di, offset arr + 2
     mov si, di
     
     case:
        lodsb
        xor al, 32
        stosb
        loop case
     
     mov dx, offset arr + 2
     mov ah, 9
     int 21h
main endp     