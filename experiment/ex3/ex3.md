(2)  

```assembly
mov ax,2000h   ax=2000h
mov ss,ax
mov sp,0       ss=2000h  sp=0
add sp,10      sp=000ah
pop ax         ax=076ch  sp=000ch
pop bx         bx=7206h  sp=000eh
push ax        sp=000ch
push bx        sp=000ah
pop ax         ax=7206h  sp=000ch
pop bx         bx=076ch  sp=000eh

mov ax,4c00h
int 21h
```

