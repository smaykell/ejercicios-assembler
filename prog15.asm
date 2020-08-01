datos segment
  fil db 0
  col db 40
  moc db 0
datos ends

pila segment stack
  db 4Eh dup (?) 
pila ends

codigo segment
  assume ds:datos,cs:codigo,ss:pila
  inicio: mov ax,datos
          mov ds,ax
		  
		  mov cx,0
	  cm: cmp cx,8h
		  je fin
		  push cx
		  call arbol
		  add sp,2
	      call retardo
		  call retardo
		  call retardo
		  call retardo
		  call retardo
		  mov fil,0
		  mov col,40
		  inc cx
		  jmp cm
		  	  
	 fin: mov ah,4Ch
	      int 21h

  arbol proc
         push ax
	     push bx
	     push cx
	     push dx
	     push bp
	
         mov bp,sp
	     add bp,0Ch
	     mov dx,0
	     mov ax,[bp]
	     mov cx,10h
	     mul cx
	     mov moc,al
	
         mov cx,1
		 
    buc: cmp fil,10h
	     je finp
	     mov ah,02h 
         mov bh,0
	     mov dh,fil
	     mov dl,col
	     int 10h
		  
	     mov ah,09h
	     mov al,2Ah
	     mov bh,0
	     mov bl,moc
	
	     int 10h
	     add cx,2
	     dec col
	     inc fil
	     inc moc
	     jmp buc
	
   finp: pop bp
	     pop dx
	     pop cx
	     pop bx
	     pop ax
         ret 
  arbol endp
  
  retardo proc
        push cx
	    mov cx,0
    s:  cmp cx,0FFFFh
	    je sa
	    inc cx
	    jmp s
    sa: pop cx
	    ret
  retardo endp
		  
codigo ends
end inicio