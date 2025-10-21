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

### Reflexión   
Después de ver el segundo video, entendí que la GPU tiene que ser tan rápida y trabajar de forma paralela porque en cada segundo debe procesar millones o incluso billones de cálculos para crear las imágenes que vemos en pantalla. Cada cuadro de un videojuego tiene miles de triángulos, luces, sombras y texturas que deben calcularse al mismo tiempo.  
Por eso la GPU no trabaja como un procesador normal (que hace una tarea a la vez), sino que tiene miles de núcleos que pueden ejecutar muchas operaciones al mismo tiempo, logrando que todo el proceso sea fluido y que los gráficos se vean en movimiento sin pausas ni retrasos.  

## Actividad 2  
### ¿Cómo funciona?  
El shader se encarga de dibujar un rectángulo en pantalla, pero en lugar de usar el color que yo le doy con ofSetColor, calcula el color directamente desde la GPU. Cuando activo el shader (shader.begin()), cada píxel cambia su color dependiendo de su posición en la ventana, creando un degradado.  

### ¿Qué resultados obtuviste?   
Al ejecutar el código con el shader activo, obtuve un degradado de colores donde el tono magenta aumenta de izquierda a derecha y el azul aumenta de abajo hacia arriba, mientras que el blanco se mantiene fijo. En cambio, cuando comenté el shader (dejando solo ofDrawRectangle), el rectángulo se volvió completamente blanco, sin degradado. Así:  

![alt text](<Imagen de WhatsApp 2025-10-20 a las 10.03.21_ae25f629.jpg>)
y con los cambios se genero esto:  

![alt text](<Imagen de WhatsApp 2025-10-20 a las 10.03.21_ae25f629-1.jpg>)  

### ¿Estás usando un vertex shader?  
Sí, estoy usando un vertex shader. El archivo se encarga de transformar la posición de los vértices del rectángulo mediante la matriz modelViewProjectionMatrix, este define dónde se dibuja cada vértice.  

### ¿Estás usando un fragment shader?  
Sí, también estoy usando un fragment shader. Este es el que calcula el color de cada píxel usando la posición del fragmento en pantalla (gl_FragCoord). Gracias a eso se genera el efecto de degradado.  

### Analiza el código de los shaders. ¿Qué hace cada uno?
- Vertex Shader:  
Este shader toma la posición de cada vértice y la multiplica por la matriz de transformación para ubicar el rectángulo correctamente en la pantalla. No pinta nada, solo define la posición.  

- Fragment Shader:  
Este shader usa las coordenadas de cada fragmento para calcular su color. Divide la posición x y y por el ancho y alto de la ventana para obtener valores entre 0 y 1, generando un degradado de color según la ubicación en pantalla.  

Si seguimos con el tutorial, estas son las evidencias:

### Añadiendo uniformes  
![alt text](<Imagen de WhatsApp 2025-10-20 a las 10.12.16_de934ef9.jpg>)

Si comento las lineas "shader.begin() y shader.end()", crea esto:   

![alt text](<Imagen de WhatsApp 2025-10-20 a las 10.14.02_eff8eb4f.jpg>)  
y si le añado algo de interactividad me crea esto:  
![alt text](<Imagen de WhatsApp 2025-10-20 a las 10.16.52_2a850da8.jpg>)  

### Texturas  
Resultado, 
![alt text](image.png)

EL resultado con alfas 
![alt text](image-1.png)