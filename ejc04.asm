datos segment 
  arr dw 15h,2h,25h,18h,9h,6h,1h,32h,10h
datos ends

pila segment stack
  db 4Eh dup(?)
pila ends


codigo1 segment
    assume cs:codigo1,ds:datos,ss:pila
  inicio:  mov ax,datos
           mov ds,ax
		            
		   mov dx,offset arr
		   
		   push 3h  ;dato buscado
		   push 09h ;numero de datos
		   push dx  ;inicio de array
		   call far ptr buscar
		   
		   add sp,04h
		   pop dx  ;posicion donde esta ( -1(FFFF)  si no esta )  
	  fin: mov ah,4Ch
	       int 21h


codigo1 ends

codigo2 segment
    assume cs:codigo2
           buscar proc far
		     push ax
		     push cx
			 push dx
			 push bp
			 push si
		     
			 mov bp,sp
			 add bp,0Eh
			 mov si,[bp]
			 add bp,2
			 mov cx,[bp]
			 add bp,2
			 mov dx,[bp]
			 
		 f1: cmp  cx,0h
			 je finb
			 cmp [si],dx
			 je devdir
			 add si,02h
			 dec cx
			 mov ax,-1h
			 mov [bp],ax
			 jmp f1
			 
	 devdir: mov [bp],si
       finb: pop si
	         pop bp
			 pop dx
			 pop cx 
			 pop ax
	         ret
           buscar endp
codigo2 ends

end inicio 
