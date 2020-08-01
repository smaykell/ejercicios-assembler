;convertir numero a cadena
datos segment
  buf db 5h dup(?)
datos ends

pila segment stack
  db 4Eh dup (?)
pila ends  

codigo segment 
  assume cs:codigo,ds:datos,ss:pila
  inicio: mov ax,0FFh
          mov bx,0Ah
          mov cl,0h
	 sig: mov dx,0h
		  div bx
		  push dx
		  inc cl
		  cmp ax,0h
		  jne sig	  
		  mov si,offset buf  
	  de: cmp cl,0h
	      je imp
	      pop dx
		  add dx,30h
		  mov [si],dl
		  inc si
		  dec cl
		  jmp de  
	 imp: mov byte ptr [si],24h
	      mov ah,09h
	      mov dx,offset buf
	      int 21h
	 fin: mov ah,4Ch
	      int 21h
codigo ends 
end inicio









