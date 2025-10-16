# Unidad 7  

## Actividad 1
Según los videos responder estas preguntas:   

### ¿Qué son los vértices?  
Los puntos que dan forma a los modelos 3D. Cada uno tiene información como su posición en el espacio, color, y dirección de la superficie. En conjunto, forman las figuras que vemos en un entorno 3D. 

### ¿Con qué figura geométrica se dibuja en 3D?  
Se construye con triángulos. Los modelos están compuestos por miles de estos triángulos unidos, creando lo que se llama una malla o mesh.  

### ¿Qué es un shader?  
Los shaders son pequeños programas que corren en la tarjeta gráfica (GPU). Su función es darle apariencia a los modelos, controlando cómo se ven los colores, las luces, las sombras y las texturas en cada superficie.  

### ¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?  
Los fragmentos son grupos de píxeles que pertenecen al mismo triángulo. Cada fragmento representa un posible punto visible en la pantalla, y luego se decide su color final.  

### ¿Qué es un fragment shader?  
El fragment shader se encarga de calcular el color de cada fragmento, aplicando efectos como la iluminación, las sombras, los reflejos y las texturas que hacen que las superficies se vean más realistas.  

### ¿Qué es un vertex shader?  
El vertex shader trabaja con cada vértice del modelo, transformando su posición desde el espacio 3D hasta el espacio 2D de la pantalla. Es el primer paso dentro del proceso de renderizado.   

### ¿Al proceso de determinar qué pixels del display va a cubrir cada triángulo de una mesh se le llama?  
Rasterización, que  es el proceso que determina qué píxeles del monitor van a ser cubiertos por cada triángulo de la malla. Básicamente, convierte los triángulos del modelo en fragmentos listos para colorear.  

### ¿Qué es el render pipeline?  
Todo el recorrido que sigue una imagen desde los datos 3D hasta mostrarse en pantalla. Incluye etapas como el vertex shading, la rasterización y el fragment shading.  

### ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?  
Si hay diferencia, porque aplicar solo un color a una superficie es algo básico, mientras que aplicar una textura permite usar una imagen (por ejemplo, de madera o metal) para darle más detalle visual a la superficie, generando mas detalle visual.  

### ¿Cuál es la diferencia entre una textura y un material?  
Una textura es solo una imagen, pero un material combina varias texturas junto con propiedades como la rugosidad o el brillo, para definir cómo la luz reacciona sobre esa superficie.  

### ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?  
Para pasar un vértice del mundo 3D a la pantalla, se aplican tres transformaciones:  

- Model Matrix: posiciona el objeto en el mundo.  
- View Matrix: aplica la cámara.  
- Projection Matrix: transforma la escena al plano 2D de la pantalla.
  
### ¿Al proceso de convertir los triángulos en fragmentos se le llama?  
Se llama rasterización (es la etapa donde los triángulos se traducen en fragmentos o píxeles)  

### ¿Qué es el framebuffer?  
Un espacio en la memoria donde se guarda la imagen ya renderizada, lista para mostrarse en la pantalla del computador.  

### ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?  
Este buffer almacena la profundidad de cada píxel, para que el sistema sepa qué objetos están más cerca o más lejos. Así se evita que algo que está al fondo tape lo que está adelante.  
