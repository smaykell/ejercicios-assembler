datos segment
  x dw ?
  a dw 8
  b dw 4
  c db 5
datos ends

codigo segment
  assume cs:codigo,ds:datos
  inicio: mov ax,datos
          mov ds,ax
		  mov ax,a
		  add ax,b
		  mov bl,c
		  mov bh,00h
		  sub ax,bx
		  mov x,ax
		  
		  mov ah,02h
		  mov dx,x
		  add dx,30h
		  int 21h
		  
		  
  fin:    mov ah,4Ch
          int 21h
codigo ends

end inicio