;convertir cadena a numero
datos segment
  buf db 8h dup(?)
  msg1 db 'Ingrese numero:$',0Ah,0Dh
  n db ?
datos ends

pila segment stack
  db 4Eh dup (?)
pila ends 

codigo segment 
  assume cs:codigo,ds:datos,ss:pila
   inicio:  mov ax,datos
            mov ds,ax
		 
            mov ah,09h
		    mov dx,offset msg1
		    int 21h
			
	    	mov ah,0Ah
		    mov dx, offset buf
		    mov si,dx
		    mov byte ptr [si],04h
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
   
 codigo ends
 end inicio