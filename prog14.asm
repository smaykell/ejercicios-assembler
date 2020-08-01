datos segment
  fil db 0
  col db 40
  moc db 0
datos ends

codigo segment
  assume ds:datos,cs:codigo
  inicio: mov ax,datos
          mov ds,ax
		  push 0
		  call arbol
		  add sp,2
	 fin: mov ah,4Ch
	      int 21h

  arbol proc
    mov bp,sp
	add bp,2
	mov dx,0
	mov ax,[bp]
	mov cx,16
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
	
	finp:
    ret 
  arbol endp
		  
codigo ends
end inicio