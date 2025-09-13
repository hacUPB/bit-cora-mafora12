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