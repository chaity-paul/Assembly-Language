.model small
.data
 nl db 10, 13, '$'
 arr db 100, ?, 100 dup('$')
 .code 
 
 proc main 
    mov ax, @data
    mov ds, ax
    mov es , ax
    
    lea dx, arr
    mov ah, 10
    int 21h  
    ; cin >> arr
    ; arr[1] = arr.size()
    
    lea dx, nl
    mov ah, 9
    int 21h
    
    mov dl, arr[1]  
    ; arr [1] indicate korteche, amra koto gula charcter input nisi
    
    mov bl, dl
    mov ah, 2
    int 21h
    
    lea dx, nl
    mov ah, 9
    int 21h
    
    mov dx, offset arr + 2 ; first two elelment are reserve for 
    ; its purpose
    ; arr[0] for buffer size
    ; arr[1] for input size
    
    mov ah, 9
    int 21h 
    
    
    
    main endp
 end