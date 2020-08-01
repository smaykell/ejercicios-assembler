;muestra del 0 al 9 indefinidamente hasta presionar Esc
datos segment
  fil db 5  ;fila donde se mostrara caracter
  col db 5  ;columna donde se mostrara caracter
  car db ?  ;almacena codigo ascii del numero
datos ends

pila segment stack
 db  28 dup (?)
pila ends

codigo segment
 assume ds:datos,ss:pila,cs:codigo
ini: mov ax,datos
     mov ds,ax
     call num 
fin: mov ah,4Ch
     int 21h

  num proc
       ;selecciona posicion de cursor (fil,col)
       mov ah,02h   ;servicio posicionar cursor
	   mov bh,0     ;numero de pagina
	   mov dh,fil   ;posicion fila
	   mov dl,col   ;posicion columna
	   int 10h      ;ejecutamos interrupcion de servicio de video
   rn: mov car,30h  ;iniciar carater 30h( 0-> ascii )
  imp: cmp car,39h  ;paso de 39?
	   ja rn        ;si paso de 39h lo reiniciamos a 30h 
	   ;escribe caracter en posicion del cursor
	   mov ah,0Ah   ;servicio imprimir en posicion de cursor
	   mov al,car   ;codigo ascii del caracter
       mov bh,0     ;numero de pagina
	   mov cx,1     ;numero de carateres a escribir
       int 10h      ;ejecutamos interrupcion de servicio de video
	   inc car      ;siguiente caracter
	   ;leer tecla si no es escape continuar
	   mov ah,01h   ;servicio obtiene estado de teclado
	   int 16h      ;interrupcion de teclado
	   jz imp       ;salta a imp si ZF=1 (no se a presionado tecla)
	   mov ah,00h   ;servicio lee carater teclado
	   int 16h      ;interrupcion de teclado
	   cmp al,1Bh   ;es Esc?
	   jne imp      ;si no es ir imprimir
	   ret          ;si es terminar
  num endp

codigo ends
end ini