datos segment 
  buf db 5h dup(?)
  msg1 db 'ingrese cantidad de terminos :',0Ah,0Dh,'$'
  salto db '',0Ah,0Dh,'$';para tabular la serie
  n db ?  ;cantidad de elementos
  d dw ?  ;numero de la serie para mostrar
datos ends

pila segment stack 
  db 64h dup(?)
pila ends

codigo segment
  assume cs:codigo, ds:datos, ss:pila
  inicio: mov ax,datos
          mov ds,ax
		  jmp leer
		  
		  ;la cadena que se lee la convierte a numero
		  leer proc
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
            jmp  fibonacci
        leer endp		

          ;genera la serie fibonacci y cada elemento lo apila
		  ;los almacena como numero de 2 Bytes!!!
          fibonacci proc 
		    mov cl,n
		    mov ax,00h
		    mov bx,01h
		    cmp cx,01h
		    jb imp
		    push ax
		    cmp cl,02h
		    jb imp 
		    push bx
		    sub cl,02h
		f2: cmp cl,00h
		    je imp
		    mov dx,ax
		    add dx,bx
		    push dx
		    dec cl
		    mov ax,bx
		    mov bx,dx
		    jmp f2
	   imp: jmp mostrar
		  fibonacci endp
 
          ;desapila la cantidad de numeros generados indicado por n
 mostrar: cmp n,00h
          je fin
		  mov ah,09h
          mov dx,offset salto
 	      int 21h		  
		  pop d
		  jmp imprimir
	 sgt: dec n
	      jmp mostrar
     fin: mov ah,4Ch
          int 21h  

        ;toma lo que hay en d y lo imprime como cadena
		;ejm 0Ch -->12
		imprimir proc
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
           je sgt 
           pop dx 
           int 21h   
           dec cl 
           jmp f4    
		 imprimir endp
	
codigo ends
end inicio