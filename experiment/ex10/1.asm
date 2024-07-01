assume cs:code

data segment
    db 'Welcome to masm!', 0
data ends

stack segment
    dw 8 dup (0)
stack ends

code segment
start:
    mov ax,stack
    mov ss,ax
    mov sp,16

    mov dh,18
    mov dl,30
    mov cl,15
    mov ax,data
    mov ds,ax
    mov si,0
    call show_str

    mov ax,4c00h
    int 21h

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