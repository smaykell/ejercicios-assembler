datos segment
  buf db 5h 
  msg1 db "Bienvenido a este programa$"
  msg2 db 0Ah,0Dh,'$' 
  msg3 db "0$"
datos ends

pila segment stack
  db 4Eh dup(?)
pila ends

codigo segment
  assume ds:datos, ss:pila, cs:codigo
  inicio: mov ax,datos
          mov ds,ax
		  
		  ;mostrar mensaje de bienvenida
		  mov ah,09h
	      mov dx,offset msg1
	      int 21h
		  
		  ;espera tecla presionada
 esperar: mov ah,01h
		  int 16h
		  jz esperar
		  
		  ;SI AL ES 0 SE IMPRIME AH
		  
		  ;leer tecla presionada
		  mov ah,00h
		  int 16h
		  	  
		  push ax
		  call mostrar_codigo
		  push ax
		  
		  cmp al,1Bh
		  jne esperar
		  ;si no es escape ir a esperar tecla
		  
		  
     fin: mov ah,4Ch
	      int 21h
		  
  mostrar_codigo proc
      push dx
	  push ax
	  push sp
	  
	  mov ah,09h
	  mov dx,offset msg2
	  int 21h
	  
	  mov bp,sp
	  add bp,08h
	  
	  mov ax,[bp]
	  
      mov dx,offset buf
	  
	  push dx
	  
	  mov bh,0
	  
	  cmp al,0
	  je s
	  jmp x
   s: mov bl,ah 
   mov ah,09h
	  mov dx,offset msg3
	  int 21h
	  jmp z
	  
	  
   x: mov bl,al
   z: push bx
	  call con_num_cad
	  pop ax
	  pop dx
	  
	  mov ah,09h
	  mov dx,offset buf
	  int 21h
	  
	  pop sp
	  pop ax
	  pop dx
	  
      ret
  mostrar_codigo endp
  
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