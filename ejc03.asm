;numero primo?
datos segment
  msg1 db 'Ingrese numero a evaluar :',0Ah,0Dh,'$'
  msg2 db 0Ah,0Dh,'Es primo$'
  msg3 db 0Ah,0Dh,'No es primo$'
  bufe db 8h dup (?)
datos ends

pila segment stack
  db 4Eh dup (?)
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
		mov byte ptr [si],4h
		int 21h
		
		mov dx,offset bufe
		
		push dx
		call conv_cad_num
		pop dx
		
		push dx
		call es_primo
		pop bx
		
		mov ah,09h
		cmp bx,1h
		jne no
		mov dx,offset msg2
		jmp fin
	no: mov dx,offset msg3
	
   fin: int 21h
        mov ah,4Ch
        int 21h

		conv_cad_num proc
		  push ax
		  push bx
		  push cx
		  push dx
		  push si
		  
		  mov bp,sp
		  add bp,0Ch
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
		
		;devuelve 1 si es primo
		es_primo proc
		  push ax
          push bx
          push cx
          push dx
          push bp
		  mov bp,sp
		  add bp,0Ch
          mov dx,0h		 
          mov ax,[bp]
          cmp ax,0
		  jne es1
		  mov word ptr [bp],0h
		  jmp fp
	 es1: cmp ax,1
		  jne ver
		  mov word ptr [bp],0h
		  jmp fp
	 ver: mov cx,02h
		  div cx
		  mov bx,ax
	  f1: cmp bx,cx
          jb fb1
		  mov dx,0h
		  mov ax,[bp]
		  div cx
		  inc cx
		  cmp dx,0h
		  jne f1
		  mov word ptr [bp],0h
		  jmp fp
     fb1: mov word ptr [bp],1h 
      fp: pop bp
    	  pop dx
          pop cx 
          pop bx 
          pop ax
          ret		  
		es_primo endp
 codigo ends
 end inicio