assume cs:code

data segment
    db 10 dup (0)
data ends

stack segment
    dw 16 dup (0)
stack ends

code segment
start:
    mov ax,stack
    mov ss,ax
    mov sp,20h

    mov ax,24487
    mov bx,data
    mov ds,bx
    mov si,0
    call dtoc

    mov dh,8
    mov dl,3
    mov cl,2
    call show_str

    mov ax,4c00h
    int 21h

dtoc:
    push cx
    push dx
    push bx
    push si
    push di
    mov bx,10
s:
    mov dx,0
    mov cx,ax
    jcxz dtoc_ok
    div bx
    add dx,30h
    inc di
    push dx
    jmp s
dtoc_ok:
    mov cx,di
s2:
    pop ax
    mov [si],al
    inc si
    loop s2
    pop di
    pop si
    pop bx
    pop dx
    pop cx
    ret

show_str:
    push ax
    push es
    push bx

    mov ax,0b800h
    mov es,ax
    mov bx,0

    mov ax,00a0h
    mul dh
    add bx,ax
    mov ax,2
    mul dl
    add bx,ax

    mov dx,cx
    sub cx,cx
s0:
    mov cl,[si]
    jcxz ok
    mov es:[bx],cl
    mov es:[bx+1],dl
    add bx,2
    inc si
    jmp s0
ok:
    pop bx
    pop es
    pop ax
    ret
code ends

end start