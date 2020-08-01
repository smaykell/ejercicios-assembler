datos segment 
  buf db 5h dup(?)
  msg1 db 'ingrese cantidad de terminos :',0Ah,0Dh,'$'
  salto db '',0Ah,0Dh,'$'
  n db ?  
  d dw ?  
datos ends

pila segment stack 
  db 64h dup(?)
pila ends

codigo segment
  assume cs:codigo, ds:datos, ss:pila
  inicio: mov ax,datos
          mov ds,ax
          call leer_n
		  call fibonacci
     fin: mov ah,4Ch
          int 21h  

         leer_n proc 
		    push ax
			push bx
			push cx
			push dx

		    mov ah,09h
		    mov dx,offset msg1
		    int 21h
			
	    	mov ah,0Ah
		    mov dx, offset buf
		    mov si,dx
		    mov byte ptr [si],03h
		    int 21h
			
			mov cl,0Ah 
		    inc si
            mov dl,[si]
            mov bl,00h
            mov ch,01h
            mov ax,00h   
        f1: inc si
            mov bh,00h
            mov bl,[si]
            sub bl,30h
            add ax,bx   
            cmp dl,ch   
            je guardar     
            mul cl       
            inc ch     
		    jmp f1 
   guardar: mov n,al

			pop dx
			pop cx
			pop bx
			pop ax
			ret 
		  leer_n endp
		 
          fibonacci proc
		    push ax
			push bx
			push cx
			push dx	
			
            mov cl,n
		    mov ax,00h
		    mov bx,01h
		    cmp cx,01h
		    jb finserie
		    push ax
		    cmp cl,02h
		    jb finserie
		    push bx
		    sub cl,02h
		f2: cmp cl,00h
		    je finserie
		    mov dx,ax
		    add dx,bx
		    push dx
		    dec cl
		    mov ax,bx
		    mov bx,dx
		    jmp f2
  finserie: 
   mostrar: cmp n,00h
            je fins
		    mov ah,09h
            mov dx,offset salto
 	        int 21h		  
		    pop d 
		    call con_num_cad
	   sgt: dec n
	        jmp mostrar

      fins: pop dx
			pop cx
			pop bx
			pop ax
			ret 
          fibonacci endp
		  
		  con_num_cad proc
            mov bx,d 
		    mov bh,0
            mov cl,0
	    f3: mov dl,0Ah
		    mov ah,0
            mov al,bl 
            div dl
            mov bl,al  
            mov dl,ah 
            add dl,30h
		    mov dh,0
            push dx  
            inc cl
            cmp bl,0h
            ja f3 
            mov ah,02h
        f4: cmp cl,0
            je finc 
            pop dx 
            int 21h   
            dec cl 
            jmp f4 
	  finc: ret
		  con_num_cad endp 
codigo ends
end inicio