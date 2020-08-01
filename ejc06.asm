datos segment 
  buf db 5h dup (?)
datos ends

pila segment stack
  db 4Eh dup (?)
pila ends

codigo segment 
  assume ds:datos,ss:pila,cs:codigo
  
 inicio: mov ax,datos
         mov ds,ax
		 mov dx,offset buf
		 push dx
         push 0FFFFh
		 call con_num_cad
		 add sp,4
		 mov ah,09h
		 int 21h
    fin: mov ah,4Ch
	     int 21h
		 
  con_num_cad proc 
      push ax
	  push bx
	  push cx
	  push dx
	  push bp
	  push si
	  
	  mov bp,sp
	  add bp,0Eh
      mov ax,[bp]
      mov cx,0
	  mov bx,0Ah
  sg: mov dx,0
	  cmp ax,0
	  je imp
      div bx
	  push dx
	  inc cx
	  jmp sg
	  
      add bp,2
      mov si,[bp]
 imp: cmp cx,0
	  je fp
	  mov ah,02h
	  pop dx
	  add dx,30h
	  mov [si],dl
	  inc si
	  dec cx
	  jmp imp
  fp: mov byte ptr [si],24h
      pop si
      pop bp
      pop dx
      pop cx
      pop bx
      pop ax
	  ret
 con_num_cad endp
codigo ends
end inicio