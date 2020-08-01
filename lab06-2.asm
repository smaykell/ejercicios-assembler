datos segment
  fil db 12
  col db 1
datos ends

pila segment stack
  db 4Eh dup(?)
pila ends

codigo segment
  assume ds:datos,cs:codigo,ss:pila
  inicio: mov ax,datos
          mov ds,ax
		  
  sigpos: cmp col,78
		  ja fin
		  
		  push 2Ah
		  call far ptr graf_cruz
		  add sp,2
		  
		  mov cx,0
   bucle: cmp cx,0FFFFh
		  je finbucle
		  inc cx
		  jmp bucle
		  
finbucle: push 20h
		  call far ptr graf_cruz
		  add sp,2
		  inc col
		  
		  jmp sigpos
		  
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
  graf_cruz endp
  
codigo2 ends
end inicio