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

stacksg segment
    dw 8 dup (0)
stacksg ends

codesg segment
start:
    mov ax,datasg
    mov es,ax
    mov ax,table
    mov ds,ax
    mov ax, stacksg
    mov ss,ax
    mov sp,10h

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

    mov ax,4c00h
    int 21h
codesg ends

end start