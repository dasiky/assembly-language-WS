assume cs:code

stack segment
    dw 8 dup (0)
stack ends

code segment
start:
    mov ax,stack
    mov ss,ax
    mov sp,10h

    mov ax,4240h
    mov dx,0f0fh
    mov cx,0ch
    call divdw

    mov ax,4c00h
    int 21h
divdw:
    push bx
    push ax
    mov ax,dx
    mov dx,0
    div cx
    mov bx,ax
    pop ax
    div cx
    mov cx,dx
    mov dx,bx
    pop bx
    ret
code ends

end start