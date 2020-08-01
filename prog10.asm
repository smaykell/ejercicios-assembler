datos segment
  msg1 db 'Ingrese cantidad de elementos: ',0Ah,0Dh,'$'
  buf db 08h dup(?)
  n dw ?
datos ends

pila segment stack
  db 64h dup(?)
pila ends

codigo segment
  assume cs:codigo,ds:datos,ss:pila
    inicio: mov ax,datos
	        mov ds,ax
			
			mov ah,09h
			mov dx,offset msg1
			int 21h
			
			mov ah,0Ah
			mov dx,offset bufe
			mov si,dx
			mov byte ptr [si],05h
            int 21h

            push dx	
            call far ptr conv_cad_num
            pop n

			
			
	   fin: mov ah,4Ch
	        int 21h
			
			

codigo ends

funciones segment
  assume cs:funciones
  
           ;buffer de salida
		   ;numero
		   
		   
           conv_num_cad proc far
		     push ax
		     push bx
		     push cx
		     push dx
		     push si
			 mov bp,sp
			 
			 mov si,[bp]
			 add bp,02h
			 
			 mov cx,0
			 
			 mov ax,[bp]
		sig: mov dx,0h
			 
			 mov cx,0Ah
			 div cx
			 add dx,30h
			 push dx
			 inc cx
			 cmp ax,0h
			 jne sig
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
		   conv_num_cad endp
  
           conv_cad_num proc far
		     push ax
		     push bx
		     push cx
		     push dx
		     push si
		     mov bp,sp
		     add bp,0Eh
		     mov si,[bp]		  
		     mov cl,0Ah 
		     inc si
             mov dl,[si]
             mov bl,00h
             mov ch,01h
		     mov ax,00h   
         f2: inc si
             mov bh,00h
             mov bl,[si]
             sub bl,30h
             add ax,bx   
             cmp dl,ch   
             je fp2     
             mul cl       
             inc ch     
		     jmp f2 
		     mov ah,0
        fp2: mov [bp],ax
             pop si
		     pop dx
		     pop cx
		     pop bx
		     pop ax
		     ret  
		   conv_cad_num endp


funciones ends
end inicio 
