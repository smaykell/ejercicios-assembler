datos segment 
  arrA db 15h,2h,25h,18h,9h,6h,1h,32h,10h
  arrB db 1h,2h,5h,9h,9h,6h,1h,5h,7h
  arrC db 9h dup (?)
datos ends

pila segment stack
  db 4Eh dup(?)
pila ends


codigo1 segment
    assume cs:codigo1,ds:datos,ss:pila
  inicio:  mov ax,datos
           mov ds,ax
		   
		   push 09h
		   
		   mov dx,offset arrA
		   push dx
		  
		   mov dx,offset arrB
		   push dx
		   
		   mov dx,offset arrC
		   push dx
		   
		   call far ptr sum_arr
		   
		   add sp,06h
		            
	
	  fin: mov ah,4Ch
	       int 21h


codigo1 ends

codigo2 segment
    assume cs:codigo2
	
           sum_arr proc far
		     push ax
			 push bx
			 push cx
			 push dx
			 push si
			 push bp
			 mov bp,sp
			 add bp,10h
			 add bp,02h
			 mov bx,[bp] ;dir. arrB
			 add bp,02h
			 mov si,[bp] ;dir. arrA
			 add bp,02h
			 mov cx,[bp] ;n elementos
			 mov dh,0h
			 mov ah,0h
		 f1: cmp cx,0h
			 je fb
			 mov dl,[bx]
			 mov al,[si]
			 add al,dl
			 push ax
			 inc bx
			 inc si
			 dec cx
			 jmp f1
		 fb: mov cx,[bp] ;n elementos
			 sub bp,06h
			 mov si,[bp] ;dir. arrC
			 mov dx,si
			 add si,cx
			 dec si
		 f2: cmp dx,si
			 ja fp
			 pop ax
			 mov byte ptr [si],al
			 dec si
			 jmp f2
		 fp: pop bp
		     pop si
			 pop dx
		     pop cx
			 pop bx
		     pop ax 
		     ret 
		   sum_arr endp
		   
codigo2 ends

end inicio 