datos segment 
  buf db 4Eh dup (?)
  msg1 db 'Ingrese expresion postfija :',0Ah,0Dh,'$'
  msg2 db '',0Ah,0Dh,'resultado=$'
  n db 0 ; contador   
datos ends

pila segment stack 
 db 96h dup(?)
pila ends

codigo segment
 assume cs:codigo, ds:datos, ss:pila
   inicio: mov ax,datos
	       mov ds,ax
		   
		   ;mostrar mensaje
		   mov ah,09h
		   mov dx,offset msg1
		   int 21h
		 
		   ;capturar expresion
		   mov ah,0Ah
		   mov dx,offset buf
		   mov si,dx
		   mov byte ptr [si],4Ch
		   int 21h
		   
		   inc si
           mov dl,[si]		   
		   mov n,dl
		    
	   f1: cmp n,0h
		   je fin
		   inc si
		   mov ah,0h
		   mov al,[si]
		   cmp al,30h
		   jb operador
		   cmp al,39h
		   ja f1
		   sub al,30h
		   push ax
		   dec n
		   jmp f1
		   
 operador: cmp al,2Bh
           je suma
		   cmp al,2Dh
		   je resta
		   cmp al,2Ah
		   je mult
		   cmp al,2Fh
		   je divicion
		   dec n
		   jmp f1
		   
     suma: pop cx
	       pop ax
		   add ax,cx
		   dec n
		   jmp f1
		 
    resta: pop cx
	       pop ax
		   sub ax,cx
		   push ax
		   dec n
		   jmp f1
	
     mult: pop cx
           pop ax
		   mul cx
		   push ax
		   dec n
		   jmp f1
		   
 divicion: pop cx
           pop ax
		   div cx
		   push ax
		   dec n
		   jmp f1
		   	   
      fin: pop ax
           mov bx,0Ah
           mov cl,0h
	   f2: mov dx,0h
		   div bx
		   push dx
		   inc cl
		   cmp ax,0h
		   jne f2	  
		   mov si,offset buf  
	   f3: cmp cl,0h
	       je mostrar
	       pop dx
		   add dx,30h
		   mov [si],dl
		   inc si
		   dec cl
		   jmp f3  
  mostrar: mov byte ptr [si],24h
	       mov ah,09h
		   mov dx,offset msg2
		   int 21h
	       mov dx,offset buf
	       int 21h
	       mov ah,4Ch
	       int 21h
 
codigo ends
end inicio 
