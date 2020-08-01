datos segment 
 buf db 0Fh dup (?)
 msg1 db 'Ingrese expresion postfija :',0Ah,0Dh,'$'
 op1 db ?
 op2 db ?
 res dw ?
 tam db ?    
 salto db '',0Ah,0Dh,'resultado=$'
datos ends

pila segment stack 
 db 64h dup(?)
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
		   mov byte ptr [si],0Ch
		   int 21h
		   
		   inc si 
		   
		   mov cl,[si] 
		   mov tam,cl
		   
		   ;tomando siguiente elemento
	  sig: inc si
		  
		   cmp tam,0
		   je mostrar

           mov al,[si]			
		   cmp al,30h
		   jb operador
		   cmp al,39h
		   ja operador
		   jmp operando
		   
  mostrar:  mov ah,09h
            mov dx,offset salto
            int 21h
            pop dx
            ;imprimir resultado
			jmp imprimir
			imprimir proc
		   mov bx,dx 
		   mov bh,0
           mov cl,0
		 x:mov dl,0Ah
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
           ja x 
           mov ah,02h
         c:cmp cl,0
           je se 
           pop dx 
           int 21h   
           dec cl 
           jmp c   
           
       se: jmp fin
		 imprimir endp
		
		   ;es operador
		   operador proc 
		     pop ax
		     mov op2,al
		     
		     pop ax
		     mov op1,al

			 ;operar segun operador
			 mov al,[si]
			 cmp al,2Bh  ;es suma
			 je suma
			 cmp al,2Dh  ;es resta
			 je resta
			 cmp al,2Ah  ;es multiplicacion
			 je multiplicacion
			 cmp al,2Fh   ;es divicion
			 je division
		  ap: push res
		      dec tam
			  jmp sig
		   operador endp
		   
		   ;es operando
		     operando proc
		     mov ah,00h
		     mov al,[si]
			 sub ax,30h
		     push ax
			 dec tam
			 jmp sig
		   operando endp
		   
           suma proc
		     mov al,op2
			 add al,op1 
			 mov ah,00h
			 mov res,ax
             jmp ap			 
		   suma endp
		   
		   resta proc
		     mov al,op2
			 sub al,op1
			 mov ah,00h
			 mov res,ax	
             jmp ap			 
		   resta endp
		   
		   multiplicacion proc
		     mov al,op2
		     mov ah,00h
			 mov dl,op1
			 mov dh,00h
			 mul dl
			 mov res,ax
			 jmp ap 
		   multiplicacion endp
		   
		   division proc
		     mov al,op1
		     mov ah,00h
			 mov dl,op2
			 mov dh,00h
			 div dl
			 mov ah,00h
			 mov res,ax
			 jmp ap 
		    division endp

		fin: mov ah,4Ch
		   int 21h
	 
codigo ends
end inicio 

