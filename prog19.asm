datos segment
  x1 db 1
  y1 db 1
  x2 db 23
  y2 db 1
  msg1 db 'Game Over$'
datos ends

pila segment stack
  db 4Eh dup(?)
pila ends

codigo segment
  assume ds:datos,cs:codigo,ss:pila
  inicio: mov ax,datos
          mov ds,ax
		  mov dh,24
	      mov dl,y2
	
	      ;dibujar I
	      mov ah,02h
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
	  dz: push 10
		  call far ptr retardo
		  add sp,2
		  
		  ;borrar cruz
		  push 20h
		  call far ptr dib_cruz
		  add sp,2
          
		  ;incrementar col y verificar < 79
		  inc y1
		  cmp y1,79
		  je rscol
		  jmp d
		  
		  ;dibujar cruz
		d: push 2Ah
		  call far ptr dib_cruz
		  add sp,2
		  jmp l
		  
   rscol: mov y1,0
   
          ;ver si se presiono tecla
	   l: mov ah,01h
		  int 16h
		  jz dz
		 
		  mov ah,00h
		  int 16h
		     ;->leer tecla		  
		  push ax
		  call far ptr leer_tecla
		  pop ax
        
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
    mov dh,x1
	mov dl,y1
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
 b: cmp cx,0FFFh
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
  
  ;075 dec izquierda  4Bh
  ;077 dec derecha    4Dh
  ;32 espacio         20h
  
  leer_tecla proc far
    push ax
	push bp
    mov bp,sp
	add bp,08h
	mov ax,[bp]
	cmp al,0
	jne ep
	cmp ah,4Bh
	jne de
    push 1
	call mover_i
	add sp,2
	jmp o
de: cmp ah,4Dh 
    jne o
	push 0
	call mover_i
	add sp,2
ep: cmp al,20h
    jne o
    call disparar
 o: pop bp
    pop ax
    ret
  leer_tecla endp
  
  disparar proc
    mov dh,x2
	mov dl,y2
	
 k: cmp dh,0
	je fw 
	cmp dh,2
	jne j
	cmp y1,dl
	jne j
	call fin_juego

  j:cmp dh,1
    jne h
	
	mov cl,y1
	dec cl
    cmp cl,dl
	jne t
	call fin_juego
	
	t: add cl,2
	cmp cl,dl
	jne h
	call fin_juego
	
	

 h: mov ah,0Ah
	mov al,20h
	mov bh,0
	mov cx,1
	int 10h
	
	dec dh
    mov ah,02h
	mov bh,0
	int 10h
	
	mov ah,0Ah
	mov al,111
	mov bh,0
	mov cx,1
	int 10h
	
	mov cx,07FFh
 y: cmp cx,0
	je sl
	dec cx
	jmp y
sl: jmp k
fw:	mov ah,0Ah
	mov al,20h
	mov bh,0
	mov cx,1
	int 10h
    ret
  disparar endp
  
  fin_juego proc
    mov ah,09h
	mov dx,offset msg1
	int 21h
	
	mov ah,4ch
	int 21h
  
  fin_juego endp
  
  
  mover_i proc
     push ax
	 push bx 
	 push cx
	 push dx
	 push bp
	 
     mov bp,sp
	 add bp,0Ch
	 mov cx,[bp]
	 cmp cx,0
	 jne mi
	 cmp y2,79
	 je fm
	 mov ah,02h
	 mov bh,0
	 mov dh,24
	 mov dl,y2
	 int 10h
     mov ah,0Ah
	 mov al,20h	  
	 mov bh,0
	 mov cx,1
	 int 10h
	 inc y2
	 mov ah,02h
	 mov bh,0
	 mov dh,24
	 mov dl,y2
	 int 10h		
     mov ah,0Ah
	 mov al,73  
	 mov bh,0
	 mov cx,1
	 int 10h
 mi: mov cx,[bp]
	 cmp cx,1
	 jne fm
	 cmp y2,0
	 je fm
	 mov ah,02h
	 mov bh,0
	 mov dh,24
	 mov dl,y2
	 int 10h
     mov ah,0Ah
	 mov al,20h	  
	 mov bh,0
	 mov cx,1
	 int 10h
	 dec y2
	 mov ah,02h
	 mov bh,0
	 mov dh,24
	 mov dl,y2
	 int 10h
     mov ah,0Ah
	 mov al,73  
	 mov bh,0
	 mov cx,1
	 int 10h
 fm: pop bp
     pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret
  mover_i endp
  
codigo2 ends
end inicio