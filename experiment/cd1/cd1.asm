assume cs:codesg

datasg segment
	;定义年份,占84个字节
	db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982'
	db '1983', '1984', '1985', '1986', '1987', '1988', '1989', '1990'
	db '1991', '1992', '1993', '1994', '1995'
	;定义收入, 占84个字节
	dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486
	dd 50065, 97479, 140417, 197514, 345980, 590827, 803530, 1183000
	dd 1843000, 2759000, 3753000, 4649000, 5937000
	;定义雇员人数，占42个字节
	dw 3, 7, 9, 13, 28, 38, 130, 220
	dw 476, 778, 1001, 1442, 2258, 2793, 4037,5635
	dw 8226, 11542, 14430, 15257, 17800
datasg ends

table segment
	;定义21行的一个表格，每行16个字节，共占246个字节
	db 21 dup ('year summ ne ?? ')
table ends

string segment
    db 128 dup (0)
string ends

stacksg segment
    dw 32 dup (0)
stacksg ends

codesg segment
; 程序入口
start:
    mov ax,datasg
    mov es,ax
    mov ax,table
    mov ds,ax
    mov ax,stacksg
    mov ss,ax
    mov sp,40h

    mov bx,0
    mov di,0
    mov si,84
    mov bp,168
    mov cx,21
s0:
    push cx
    push bx
    mov cx,4
s1:
    mov al,es:[di]
    mov [bx],al
    inc bx
    inc di
    loop s1

    inc bx
    mov cx,4
s2:
    mov al,es:[si]
    mov [bx],al
    inc si
    inc bx
    loop s2

    inc bx
    mov ax,es:[bp]
    mov [bx],ax
    add bp,2
    add bx,3

    mov dx,[bx-6]
    mov ax,[bx-8]
    div word ptr [bx-3]
    mov [bx],ax

    pop bx
    add bx,10h
    pop cx
    loop s0

    mov ax,string
    mov ds,ax

    mov ax,table
    mov es,ax
    mov cx,21
    mov dx,0100h
    mov bx,0
s3:
    call show_line
    add bx,10h
    add dh,1
    loop s3

    mov ax,4c00h
    int 21h

;显示一行, es:bx 指向行首
show_line:
    push cx
    push dx
    mov ax,es:[bx]
    mov ds:[0],ax
    mov ax,es:[bx+2]
    mov ds:[2],ax
    mov al,0
    mov ds:[4],al
    mov si,0
    mov cl,00001011b
    call show_str

    mov ax,es:[bx+5]
    push dx
    mov dx,es:[bx+7]
    call dtoc
    pop dx
    mov dl,9
    call show_str

    mov ax,es:[bx+10]
    push dx
    mov dx,0
    call dtoc
    pop dx
    mov dl,19
    call show_str

    mov ax,es:[bx+13]
    push dx
    mov dx,0
    call dtoc
    pop dx
    mov dl,25
    call show_str

    pop dx
    pop cx
    ret

; 显示字符串, dh=行，dl=列，cl=颜色，ds:si 指向字符串
show_str:
    push ax
    push es
    push bx
    push cx
    push si
    push dx

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
show_str_s0:
    mov cl,[si]
    jcxz show_str_ok
    mov es:[bx],cl
    mov es:[bx+1],dl
    add bx,2
    inc si
    jmp show_str_s0
show_str_ok:
    pop dx
    pop si
    pop cx
    pop bx
    pop es
    pop ax
    ret

; 防溢出除法，ax=被除数低16位，dx=被除数高16位，cx=除数，
; 返回值 dx=商高16位，ax=商低16位，cx=余数
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

; 16进制数转10进制字符串，ax=低16位，dx=高16位，ds:si 指向字符串首地址
dtoc:
    push cx
    push dx
    push bx
    push si
    push di
    push ax
    mov di,0
dtoc_s:
    mov cx,10
    call divdw
    mov bx,cx
    mov cx,ax
    or cx,dx
    inc di
    add bx,48
    push bx
    jcxz dtoc_ok
    jmp dtoc_s
dtoc_ok:
    mov cx,di
    mov ax,0
    mov [di],ax
    mov di,0
dtoc_s2:
    pop ax
    mov [di],al
    inc di
    loop dtoc_s2

    pop ax
    pop di
    pop si
    pop bx
    pop dx
    pop cx
    ret
codesg ends

end start