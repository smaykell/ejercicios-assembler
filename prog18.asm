datos segment
  fil db 1
  col db 1
  colI db 1
  
datos ends

pila segment stack
  db 4Eh dup(?)
pila ends

codigo segment
  assume ds:datos,cs:codigo,ss:pila
  inicio: mov ax,datos
          mov ds,ax
		  
		  mov dh,25
	      mov dl,colI
	
	
	      ;dibujar I
	      mov ah,02h
	      dec dh
	      mov bh,0
	      int 10h
			
          ;imprimimos 
	      mov bx,73
	      mov ah,0Ah
	      mov al,bl
	      mov bh,0
	      mov cx,1
	      int 10h
	
		  
		  ;dibujar cruz
		  push 2Ah
		  call far ptr dib_cruz
		  add sp,2
		  
		  ;retardo
	  dz: push 1h
		  call far ptr retardo
		  add sp,2
		  
		  ;borrar cruz
		  push 20h
		  call far ptr dib_cruz
		  add sp,2
          
		  ;incrementar col y verificar < 79
		  inc col
		  cmp col,79
		  je rscol
		  jmp d
		  
		  ;dibujar cruz
		d: push 2Ah
		  call far ptr dib_cruz
		  add sp,2
		  jmp l
		  
   rscol: mov col,1
   
          ;ver si se presiono tecla

		  
		  l:
          mov ah,01h
		  int 16h
		  jz dz
		  
		  mov ah,00h
		  int 16h
		     ;->leer tecla		  
		    
		 call far ptr leer_tecla
          
		  ;si no es esc ir a 2
		  cmp al,1Bh
		  jne dz
		 
		  
		  
	 fin: mov ah,4Ch
	      int 21h 
codigo ends

codigo2 segment
  assume cs:codigo2

  
  dib_cruz proc far
    push ax
	push bx
	push cx
	push dx
	push bp
	mov bp,sp
	add bp,0Eh
    mov dh,fil
	mov dl,col
	mov ah,02h
	dec dh
	mov bh,0
	int 10h
	mov bx,[bp]
	mov ah,0Ah
	mov al,bl
	mov bh,0
	mov cx,1
	int 10h
	mov ah,02h
	inc dh
	dec dl
	mov bh,0
	int 10h
	mov bx,[bp]
	mov ah,0Ah
	mov al,bl
	mov cx,3
	int 10h
	mov ah,02h
	inc dl
	inc dh
	mov bh,0
	int 10h
	mov bx,[bp]
	mov ah,0Ah
	mov al,bl
	mov cx,1
	int 10h
	pop bp
	pop dx
	pop cx
	pop bx
	pop ax
    ret	
  dib_cruz endp
  
  retardo proc far
    push ax
	push cx
	push bp
    mov bp,sp
	add bp,0Ah
	mov ax,[bp]
 w: cmp ax,0
	je f
	mov cx,0
 b: cmp cx,0FFh
	je fb
	inc cx
	jmp b
fb: dec ax
	jmp w	
 f: pop bp
	pop cx
	pop ax
	ret
  retardo endp
  leer_tecla proc far
     ;es derecha
	 ;es izquierda
	 ;es espacio
    ret
  leer_tecla endp
  
codigo2 ends
end inicio