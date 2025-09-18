<<<<<<< HEAD
La obra de arte generativo dinámica se basa en una cuadrícula de formas geométricas que cambian de aspecto, cantidad y movimiento a partir de la interacción del usuario. Al mover el mouse horizontalmente, se controla la cantidad de figuras en cada celda, mientras que al desplazarlo verticalmente, se modifica el ángulo y la rotación de las formas. Además, con las teclas el usuario puede alterar la densidad de la cuadrícula, cambiar entre diferentes modos de visualización (rectángulos apilados, patrones de color y círculos en movimiento), e incluso guardar capturas de los resultados, convirtiendo la experiencia en un proceso creativo abierto y único.

En cuanto a los requisitos:

Combinación de estructuras de datos: la cuadrícula se maneja como un arreglo bidimensional, donde cada celda guarda la posición de un grupo de figuras. Adicionalmente, se puede imaginar el uso de una pila o cola para gestionar el ciclo de vida de las formas: por ejemplo, una pila para apilar nuevas figuras en cada celda cuando aumenta el count, y una cola para eliminar las más antiguas cuando desaparecen, evitando que la memoria se sature.

Interactividad: el código ya incluye varias formas de interacción: el movimiento del mouse cambia el número y la transformación de las figuras, y las teclas permiten modificar modos de visualización, la cantidad de filas y columnas de la cuadrícula o guardar un fotograma en PNG. Esto hace que la obra responda directamente a las decisiones del usuario, dándole dinamismo.

Gestión de memoria: en un contexto creativo, la memoria se gestiona liberando los elementos que ya no se muestran en pantalla. Es decir, cuando la pila o la cola eliminan figuras que se salen del rango o dejan de ser visibles, se asegura que no queden “restos” consumiendo recursos. Así, el programa puede correr indefinidamente sin generar fugas de memoria, manteniendo fluidez en la animación.
=======
## Construcción de aplicaciones interactivas
Para este reto construí una aplicación en openFrameworks (C++) donde apliqué estructuras de datos (listas enlazadas, colas y pilas) para manejar posiciones, colores y modos de dibujo. El programa genera un arte interactivo en una grilla de tiles, donde puedo cambiar entre tres modos gráficos diferentes y controlar la cantidad de repeticiones según el movimiento del mouse.

### 1. Lista enlazada
```cpp
void ofApp::setup() {
    tileCountX = 6;
    tileCountY = 6;

    // Crear posiciones con lista enlazada
    for (int y = 0; y <= tileCountY; y++) {
        for (int x = 0; x <= tileCountX; x++) {
            positions.addNode(x, y);
        }
    }
}
```

Cada nodo guarda x, y y un puntero al siguiente.

### 2. Cola (queue) para almacenar colores
```cpp
colors.push(ofColor::red);
colors.push(ofColor::blue);
colors.push(ofColor::green);
colors.push(ofColor::yellow);
```

### 3. Pila para guardar el historial de modos de dibujo y poder retroceder.  
```cpp
if (key == '1') { drawMode = 1; modeHistory.push(drawMode); }
if (key == '2') { drawMode = 2; modeHistory.push(drawMode); }
if (key == '3') { drawMode = 3; modeHistory.push(drawMode); }
```

### 4. Modos de dibujo (arte generativo)

    - Modo 1: rectángulos en espiral.  
 
    - Modo 2: rectángulos con degradado y rotación progresiva.  

    - Modo 3: círculos en espejo con escalado.  

Ejemplo de uno de ellos 
```cpp
void ofApp::drawMode2(float posX, float posY, float tileW, float tileH) {
    if (count <= 0) return;

    ofPushMatrix();
    ofTranslate(posX, posY);
    ofNoFill();

    for (int i = 0; i < (int)count; i++) {
        // --- obtiene color de la cola (si existe) de forma segura ---
        ofColor currentColor = ofColor::fromHex(0xA6A6A6); // color por defecto (gris)
        if (!colors.empty()) {
            currentColor = colors.front();
            // rotación circular: sacar y volver a meter
            colors.pop();
            colors.push(currentColor);
        }

        // --- aplica color al dibujo ---
        ofSetColor(currentColor, 200); // alpha 200

     
        float t = (float)i / (float)count;
        ofColor highlight = currentColor.getLerped(ofColor::white, t * 0.5f);


        // --- dibujo de antes ---
        ofRotateDeg(45); // QUARTER_PI
        ofDrawRectangle(-tileW / 2, -tileH / 2, tileW, tileH);

        float scaleFactor = 1.0f - 3.0f / (float)count;
        ofScale(scaleFactor, scaleFactor);
        ofRotateDeg(para * 90);
    }

    ofPopMatrix();
}
```

### 5. interactivos con el tecldo   
```cpp
if (key == 'c' || key == 'C') {
    positions.clear();
}

if (key == 'r' || key == 'R') {
    positions.clear();
    for (int y = 0; y < tileCountY; y++) {
        for (int x = 0; x < tileCountX; x++) {
            positions.addNode(x, y);
        }
    }
}
```

##  Pruebas de la aplicación.  

### Lista enlazada  

Probé que al presionar la tecla "C" los nodos desaparecen "(positions.clear())."

Luego al presionar la tecla "R", los nodos se vuelven a generar.  

Para garantizar el funcionamiento de la aplicación, realicé pruebas por cada requisito de manera independiente y luego verifiqué el programa completo. de eso salio un error debido a que limpiaba la lista con la tecla "C" pero no podia volver a dibujar ningún modo , por lo tanto cree un condicional para reconstruir la lista de con la letra "R"

![alt text](image-2.png)  

Al crear el nuevo "if" genero varios errore y advertencias
![alt text](image-3.png)  

Que se pudieron solucionar al borrar una clase llamada "keyReleased" en el archivo ofApp.h la cual no estaba siendo usada y generaba errores debido a que habian definiciones duplicadas, pero al borrarlo y limpiar la solución el problema se arreglo.
Creando una buena compilación y un buen funcionamiento del programa 

### Cola de colores  

![alt text](image.png)
cuadrados/rectángulos en diferentes tonos → demuestra que los colores sí se toman de la cola.

### Pila en el historial  

Probé que al cambiar entre 1, 2, 3 se guarda el historial en la pila.  

```cpp
if (key == '1') { drawMode = 1; modeHistory.push(drawMode); }
if (key == '2') { drawMode = 2; modeHistory.push(drawMode); }
if (key == '3') { drawMode = 3; modeHistory.push(drawMode); }
```
![alt text](image-7.png)

Verifique presionando en orden 1 → 2 → 3, Luego presiona Backspace y la aplicación volvio al modo anterior. Aunque se demore un poco,

### Verificación de los nodos  
Probé uno por uno para confirmar que cada función (drawMode1, drawMode2, drawMode3) se ejecuta correctamente.

#### Modo 1.  

![alt text](image-4.png)  

En este modo se dibujan rectángulos concéntricos que se van reduciendo de tamaño y rotando progresivamente. Cada rectángulo se escala un poco menos que el anterior (ofScale). También se aplica una rotación (ofRotateDeg) controlada por la posición del mouse en el eje Y (para).  

El efecto final es un patrón dinámico que cambia dependiendo del movimiento del mouse. Implementación correcta: Se logró el comportamiento esperado de rectángulos en cascada que giran de manera fluida, confirmando que los cálculos de escalado y rotación fueron aplicados adecuadamente.
#### Modo 2.   

![alt text](image-5.png)  

En este modo utilicé un efecto de degradado de colores en los rectángulos, se interpolan dos colores (ofColor::getLerped) para simular el lerpColor de p5.js. Los rectángulos se van rotando con un ángulo fijo de 45° y se aplican escalas sucesivas. La opacidad (alpha) también cambia de manera progresiva, dando sensación de profundidad.

 Pude comprobar que los colores de la cola se aplican de manera dinámica y que el degradado se genera de forma uniforme en todos los rectángulos. El resultado visual demuestra que la lógica de mezcla de colores fue implementada satisfactoriamente.

### Modo 3.   

![alt text](image-6.png)  

Este modo dibuja círculos en espejo, distribuidos hacia la izquierda y la derecha del centro. Se crean pares de círculos simétricos con traslaciones (ofTranslate). Se van reduciendo mediante escalado y rotación, logrando un patrón visual repetitivo y en expansión. El color se mantiene fijo con transparencia, destacando la estructura generativa.


## Evidencia del video 
https://youtu.be/voNDYq-fUxc 
link de youtube 
>>>>>>> 93457566b84577ab876160f214d7cc9cf70b37d7
