datos segment 
 buf db 0Fh dup (?)
 msg1 db 'Ingrese expresion postfija :',0Ah,0Dh,'$'
 tam db ?  ;conendra la cantidad de caracteres que hay en el buffer
 salto db 0Ah,0Dh,'resultado=$'
datos ends

pila segment stack 
 db 64h dup(?)
pila ends

codigo segment
 assume cs:codigo, ds:datos, ss:pila
   inicio: mov ax,datos
           mov ds,ax
		   
		   mov ah,09h
		   mov dx,offset msg1
		   int 21h
		 
		   mov ah,0Ah
		   mov dx,offset buf
		   mov si,dx
		   mov byte ptr [si],0Ch
		   int 21h  
		   
		   inc si 
		   mov cl,[si] 
		   mov tam,cl
		   
	  sig: inc si
		   cmp tam,0
		   je mostrar
           mov al,[si]			
		   cmp al,30h
		   jb operador
		   cmp al,39h
		   ja sig
		   jmp operando
		   
  mostrar: mov ah,09h
           mov dx,offset salto
           int 21h
           pop dx
		   jmp imprimir
			 
 operador: cmp al,2Bh  
           jne resta
	 suma: pop cx
           pop ax 
		   add ax,cx
		   push ax
		   dec tam
           jmp sig
		   
    resta: cmp al,2Dh 
		   jne mult
           pop cx
           pop ax 
		   sub ax,cx
		   push ax
		   dec tam
           jmp sig		   
		   
     mult: cmp al,2Ah 
		   jne division
		   pop cx
		   pop ax
		   mov dx,0
		   mul cx
		   push ax
		   dec tam
           jmp sig		   
		   
 division: cmp al,2Fh  
		   jne sig
           pop cx
           pop ax
		   mov dx,0
		   div cx
		   push ax
		   dec tam
		   jmp sig	

 operando: mov ah,00h
           mov al,[si]
		   sub ax,30h
		   push ax
		   dec tam
		   jmp sig
            
		   ;convierte el numero (dx) a cadena 
		   ;imprime caracter por caracter
 imprimir: mov bx,dx 
		   mov bh,0
           mov cl,0
	   f1: mov dl,0Ah
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
           ja f1 
           mov ah,02h
        c: cmp cl,0
           je fin 
           pop dx 
           int 21h   
           dec cl 
           jmp c   

	  fin: mov ah,4Ch
		   int 21h
		   		 
codigo ends
end inicio 

