datos segment
  fil db 12
  col db 40
datos ends

pila segment stack
  db 32h dup(?)
pila ends

codigo segment
  assume ds:datos,cs:codigo,ss:pila
  inicio: mov ax,datos
          mov ds,ax
		  call far ptr graf_cruz
	 fin: mov ah,4Ch
	      int 21h 
codigo ends

codigo2 segment
  assume cs:codigo2
  
    graf_cruz proc far
    push ax
	push bx
	push cx
	push dx
    
	;fil->dh
	;col->dl
	
    mov dh,fil
	mov dl,col
	mov bh,0
	
	;posicion 1
	mov ah,02h
	dec dh
	int 10h
			
    ;imprimimos *
	mov ah,0Ah
	mov al,2Ah
	
	mov bh,0
	mov cx,1
	int 10h
	
	;posicion 2
	mov ah,02h
	inc dh
	dec dl
	int 10h
	
	;imprimimos *
	mov ah,0Ah
	mov al,2Ah
	mov cx,3
	int 10h
	
	;posicion 3
	mov ah,02h
	inc dl
	inc dh
	int 10h
	
	;imprimimos *
	mov ah,0Ah
	mov al,2Ah
	mov cx,1
	int 10h
	
	pop dx
	pop cx
	pop bx
	pop ax
    ret	
  graf_cruz endp
  
codigo2 ends
end inicio