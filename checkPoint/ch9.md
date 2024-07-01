### 9.1

1.  db  x,0,0
2. bx  cs
3. 0006h  00beh

### 9.2

```assembly
mov ch,0
mov cl,[bx]
jcxz ok
inc bx
```

### 9.3

inc cx

