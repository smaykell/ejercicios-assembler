datos segment 
  arr dw 15,2,25,18,9,6,1,32,10
datos ends

pila segment stack 
  db 30h dup(?)
pila ends

codigo segment
  assume cs:codigo, ds:datos, ss:pila
  inicio: mov ax,datos
          mov ds,ax   
          
		  mov dx,offset arr
		  
		  push 9
		  push dx
          call promedio
		  pop cx
		  pop bx
		  
     fin: mov ah,4Ch
          int 21h  
	
		  promedio proc
		    push ax
			push cx
			push dx
			push si
			push bp
		    mov bp,sp
			add bp,0Ch
			mov si,[bp]
			add bp,2
			mov cx,[bp]
			mov ax,0
        f1: cmp cx,0
		    je fp
		    add ax,[si]
		    add si,2
		    dec cx
		    jmp f1
	    fp: mov dx,0
	        div word ptr [bp]
			mov [bp],dx
			sub bp,2
			mov [bp],ax
			pop bp
			pop si
			pop dx
			pop cx
			pop ax
			ret 
		  promedio endp
		  		    
codigo ends
end inicio