datos segment
  x dw 12
  y dw 40  
datos ends

pila segment stack
  db 28h dup(?)
pila ends

codigo segment
   assume ds:datos,cs:codigo,ss:pila    
 inicio: mov ax,datos
         mov ds,ax 
         
         ;modo de pantalla
         mov ah,00h
         mov al,07h
         int 10h
           
         dec x
         push x
         push y
         call far ptr imp
         add sp,4
         
         inc x
         dec y 
         push x
         push y
         call far ptr imp
         add sp,4  
         
         inc y
         push x
         push y
         call far ptr imp
         add sp,4 
         
         inc y
         push x
         push y
         call far ptr imp
         add sp,4 
         
         inc x
         dec y
         push x
         push y
         call far ptr imp
         add sp,4 


     fin:mov ah,4Ch
         int 21h           
codigo ends

codigo2 segment
  assume cs:codigo2
  imp proc far
           push bp
           push ax
           push bx
           push dx
           mov bp,sp
           add bp,0Ch
           mov ax,[bp]
           mov dl,al ;asignando y
           add bp,2
           mov ax,[bp]
           mov dh,al ;asignando x
           
           ;cambiando posicion de puntero
           mov ah,02h
           mov bh,0
           int 10h
           
           ;mostrando caracter en posicion de puntero
           mov ah,0Ah
           mov al,2Ah
           mov bh,0
           mov cx,1
           int 10h 
           
           pop dx
           pop bx
           pop ax
           pop bx
           ret
         imp endp
codigo2 ends
    
end inicio
            