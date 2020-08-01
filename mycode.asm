datos segment
  suma db 0
  n db 5
datos ends

codigo segment
  assume cs:codigo,ds:datos 
  
  inicio:  mov ax,datos
           mov ds,ax                 
     leer: mov ah,0Ah
           mov dx,08h
           mov si,dx
           mov [si],06h
           int 21h
		   mov cl,0Ah 
		   inc si
           mov dl,[si]
           mov bl,00h
           mov ch,01h
           mov ax,00h   
    comp:  inc si
           mov bh,00h
           mov bl,[si]
           sub bl,30h
           add ax,bx   
           cmp dl,ch   
           je finw     
           mul cl       
           inc ch     
		   jmp comp 
   finw:   add suma,al
     
           dec n
           cmp n,0
           jne leer 

           mov bl,suma
           mov cl,0
		 w:mov dl,0Ah
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
           ja w 
           mov ah,02h
       imp:cmp cl,0
           je fin 
           pop dx 
           int 21h   
           dec cl 
           jmp imp:           
    fin:   mov ah,4Ch
           int 21h
codigo ends
end inicio
