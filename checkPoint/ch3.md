### 3.1

1. 

   * 2662H

   * E626H

   * E626H
   * 2662H
   * D6E6H
   * FD48H
   * 2C14H
   * 0000H
   * 00E6H
   * 0000H
   * 0026H
   * 000CH

2.  

   ```assembly
   mov ax,6622H     ax=6622H
   jmp 0ff0:0100    cs=0ff0H  ip=0100H
   mov ax,2000H     ax=2000H
   mov ds,ax        ds=2000H
   mov ax,[0008]    ax=c389H
   mov ax,[0002]    ax=ea66H
   ```

​		没有区别，在程序运行过程中 CS:IP 指向的就是要执行的程序，DS 段就是数据

### 3.2

1.  
   * mov ax,2000H
   * mov ss,ax
   * mov sp,0010H
2.  
   * mov ax,1000H
   * mov ss,ax
   * mov sp,0000H
