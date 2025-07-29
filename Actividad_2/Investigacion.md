Actividad 1.  

1.  ¿Qué es la entrada-salida mapeada a memoria?  

 Tecnica de los dispositivos (pantalla o teclados) que son controladas a través de posiciones especificas de la RAM.  Es decir, en lugar de usar instrucciones especiales que simplemente se leen o escriben datos en ciertas direcciones de memoria que ya están asociadas a esos dispositivos.  

2. ¿Cómo se implementa en la plataforma Hack?  

se implementa asignando posiciones fijas de memoria a la pantalla y al teclado. Por ejemplo:  

- La pantalla comienza en la dirección 16384 y ocupa hasta la 24575, porque cada dirección representa un grupo de 16 píxeles.   
- El teclado está conectado a la dirección 24576. Cuando se presiona una tecla, el código de la tecla aparece en esa dirección.  

Entonces, si uno quiere dibujar algo, simplemente escribe valores binarios en la memoria desde la posición 16384. Y si uno quiere saber si alguien presionó una tecla, lee el valor en 24576.

Actividad 2.  
