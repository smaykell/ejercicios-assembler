datos segment 
  buf db 35h dup(?)
  msg1 db 'ingrese cadena :',0Ah,0Dh,'$'
  msg2 db 'la cadena invertida :',0Ah,0Dh,'$'
datos ends

pila segment stack 
  db 64h dup(?)
pila ends

codigo segment
  assume cs:codigo, ds:datos, ss:pila
  inicio: mov ax,datos
          mov ds,ax		
		  call leer_cadena
		  call procesar_cadena
		  call mostrar
	 fin: mov ah,4Ch
          int 21h
		  
		  leer_cadena proc
		    push ax
			push dx
			push si
		    mov ah,09h
            mov dx,offset msg1
 	        int 21h
            mov ah,0Ah
		    mov dx,offset buf
		    mov si,dx
	        mov byte ptr [si],33h
		    int 21h
			pop si
			pop dx
			pop ax
            ret
          leer_cadena endp

          procesar_cadena proc
		    push ax
			push dx
			push si
			push cx
            mov si,offset buf
		    inc si
		    mov cl,[si]
		    mov ah,00h
	    f1: cmp cl,00h
	 	    je desapilar
		    inc si
		    mov al,[si]
		    push ax
		    dec cl
		    jmp f1
 desapilar: mov si,offset buf
		    inc si
		    mov cl,[si]
	    f2: cmp cl,00h
		    je find 
		    inc si
		    pop ax
			mov [si],al
		    dec cl
		    jmp f2
	  find: inc si
			mov byte ptr [si],24h
			pop cx
			pop si
			pop dx
			pop cx
			ret
          procesar_cadena endp

          mostrar proc
		    push ax
			push dx
			push si
		    mov ah,09h
            mov dx,offset msg2
 	        int 21h
		    mov si,offset buf
		    add si,02h
            mov dx,si
 	        int 21h
			pop si
			pop dx
			pop ax
			ret
          mostrar endp
		  
codigo ends
end inicio