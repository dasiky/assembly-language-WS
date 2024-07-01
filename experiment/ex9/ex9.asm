assume cs:codesg, ds:datasg

datasg segment
    db 'welcome to masm!'
    db 0000010b, 00100100b, 01110001b
datasg ends

stacksg segment
    dw 8 dup (0)
stacksg ends

codesg segment
start:
    mov ax,stacksg
    mov ss,ax
    mov ax,datasg
    mov ds,ax
    mov ax,0b800h
    mov es,ax

    mov si,10h
    mov bx,6e0h
    mov cx,3
s0:
    push cx
    mov cx,10h

    mov di,40h
    mov bp,0
s1:
    mov al,ds:[bp]
    mov es:[bx+di],al
    mov al,[si]
    mov es:[bx+di+1],al
    add di,2
    inc bp
    loop s1

    add bx,0a0h
    inc si
    pop cx
    loop s0

    mov ax,4c00h
    int 21h
codesg ends

end start