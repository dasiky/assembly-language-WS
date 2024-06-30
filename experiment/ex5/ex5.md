1. 

    1. 和原来相同
    2. 076eh  076dh 076ch
    3. X-2  X-1

2.  

    1. 和原来相同
    2. 076eh 076dh 076ch
    3. X-2  X-1
    4. N/10 向上取整

3.  

    1. 和原来相同
    2. 076ch  0770h  076fh
    3. X+3  X+4

4.  第三题代码可以正确执行，其代码段在起始位置

5.  

    ```assembly
        mov ax,c
        mov ds,ax
        mov cx,8
        mov bx,0
    s:
        mov ax,a
        mov es,ax
        mov dl,es:[bx]
        mov ax,b
        mov es,ax
        add dl,es:[bx]
        mov [bx],dl
        inc bx
        loop s
    
        mov ax, 4c00h
        int 21h
    ```

6.  

   ```assembly
       mov ax,a
       mov ds,ax
   
       mov ax,b
       mov ss,ax
       mov sp,10h
   
       mov cx,8
       mov bx,0
   s:
       mov ax,[bx]
       push ax
       add bx,2
       loop s
   
       mov ax,4c00h
       int 21h
   ```

   