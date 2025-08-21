## Actividad 1.  
Al ejecutar el programa se abre una ventana con fondo negro. En ella aparece un círculo blanco de radio 20 píxeles que sigue la posición del mouse en tiempo real. Es decir, mientras muevo el cursor, el círculo también se mueve, siempre mostrándose en la misma ubicación que el puntero.

## Actividad 2.

- 1. En el archivo ".h" lo que se hace es declarar las funciones principales que va a tener el programa, como "setup", "update" y "draw", y también dos funciones que dependen del mouse: mouseMoved y mousePressed. Además, ahí mismo se declaran las variables privadas, que en este caso son un vector que guarda las posiciones de las partículas y una variable para guardar el color de esas partículas.

- 2. Cuando corro el programa aparece una ventana con fondo negro. A medida que muevo el mouse se van dibujando círculos de radio 50 que siguen el recorrido, y eso hace como un rastro. Ese rastro no es infinito, porque cuando se pasa de 100 círculos, el primero que se había dibujado se borra. Y si hago clic, entonces los círculos cambian de color y se muestran con un tono aleatorio.

- 3. Cada vez que muevo el mouse, esta función guarda la posición en el vector de partículas. Si ya hay más de 100 posiciones, borra la primera que se había guardado para que siempre solo haya máximo 100.

- 4. Cuando presiono el mouse, cambia el color de todas las partículas a un color aleatorio. Entonces los círculos dejan de ser blancos y aparecen con un nuevo color cada vez que hago clic.

- 5. Es la primera función que corre al iniciar el programa. Aquí se pone el fondo negro y también se inicializa el color de las partículas en blanco.

- 6. Esa función sirve para actualizar la lógica del programa en cada frame. En este caso está vacía, pero igual se ejecuta todo el tiempo. Es como un espacio que queda listo por si después quiero poner alguna acción extra.

- 7. Dibuja los círculos en pantalla en las posiciones que están guardadas en el vector. Los círculos son de radio 50 y siempre se pintan con el color que está guardado en "particleColor". Como voy moviendo el mouse, se van añadiendo nuevas posiciones y el rastro de círculos va siguiendo mi recorrido. 


## Actividad 3. 

- setup()  
    "ofBackground(0);" → pinta el fondo de negro al inicio.  

    "particleColor = ofColor::white;" → inicializa el color de las partículas en blanco.  

    Esta función solo corre una vez, cuando empieza la aplicación.  

- update()  
    Está vacía, pero se ejecuta en cada frame.  
    Sirve para actualizar la lógica del programa antes de dibujar, aunque en este caso no hace nada.  

- draw()  
    "for(auto &pos: particles)" → recorre todas las posiciones guardadas en el vector particles.  

    "ofSetColor(particleColor);" → define el color de los círculos que se van a dibujar.  

    "ofDrawCircle(pos.x, pos.y, 50);" → dibuja un círculo en cada posición (x, y) del vector, con radio 50.  

    Básicamente dibuja todos los círculos guardados hasta ahora.   

- mouseMoved(int x, int y)  

    "particles.push_back(ofVec2f(x, y));" → agrega la posición del mouse al vector de partículas.

    "if (particles.size() > 100)" → revisa si hay más de 100 posiciones guardadas.

    "particles.erase(particles.begin());" → si hay demasiadas, borra la primera (la más vieja).  

    Así se guarda el rastro del mouse, pero limitado a 100 círculos.   

- mousePressed(int x, int y, int button)    

    "ofColor(ofRandom(255), ofRandom(255), ofRandom(255));" → genera un color aleatorio.  

    "particleColor = ...;" → cambia el color de las partículas al nuevo color.  

    Cuando hago clic, el rastro cambia de color de manera aleatoria.






## Actividad 5. 
- Un puntero es una variable que almacena la dirección de memoria de otra variable u objeto, en lugar de almacenar el valor directamente. Permite acceder y manipular datos indirectamente.  

- En el código hay dos punteros:

    - "vector<Sphere*> spheres" - Un vector de punteros a objetos Sphere

    - "Sphere* selectedSphere "- Un puntero individual a un objeto Sphere

    Ambos están declarados en la clase "ofApp" como miembros privados.

- En el código mostrado no se ve la inicialización, pero típicamente se haría:
    // En ofApp::setup() o constructor
    selectedSphere = nullptr; // Inicialización a null

    // O asignando la dirección de un objeto existente
    selectedSphere = new Sphere(x, y, radius);
    // O selectedSphere = &algunaEsferaExistente;

- Los punteros se usan para:

     - spheres: Almacenar dinámicamente múltiples objetos Sphere sin copiarlos
     - selectedSphere: Mantener una referencia a una esfera específica (probablemente para arrastrarla o manipularla)

- Los punteros almacenan:

        - Direcciones de memoria donde se encuentran los objetos Sphere

        - NO almacenan los objetos mismos, solo referencias a ellos

        - "selectedSphere" almacena 0 (nullptr) o la dirección de una esfera existente


## Actividad 6.

AL codigo le hace falta la lógica para seleccionar y arrastrar esferas. Por lo tanro el código actual:

- Crea esferas al hacer click 

- Las dibuja 

PERO, no detecta cuándo clickeas sobre una esfera existente, ni Permite arrastrar la esfera seleccionada
- Además, tu función mouseMoved está vacía:

"void ofApp::mouseMoved(int x, int y ){}"

La esfera no se mueve cuando arrastras el mouse, aunque hayas seleccionado una.

También, no hay destrucción de los objetos en el destructor de ofApp, lo que genera fugas de memoria porque todas las esferas creadas con new nunca se borran.

agregar estas lineas para agregarlo 

void ofApp::mouseReleased(int x, int y, int button){
    if(button == OF_MOUSE_BUTTON_LEFT){
        selectedSphere = nullptr; // dejamos de mover la esfera
    }
}

Agregar destructor para liberar memoria del heap:

ofApp::~ofApp(){
    for(auto sphere : spheres){
        delete sphere;
    }
    spheres.clear();
}


### Avtividad 7. 
- Cuando presiono la tecla “c”, el programa intenta crear un nuevo objeto Sphere y guardarlo en el vector globalVector. Pero ese objeto se crea dentro de la función, en la memoria temporal de la pila, así que mientras la función se ejecuta se dibuja bien. Cuando la función termina, el objeto deja de existir, pero el vector sigue guardando un puntero a esa memoria que ya no es válida. Por eso, al dibujar desde el vector después, los valores de posición pueden ser incorrectos y dibujar el objeto puede fallar o no mostrar nada.

- Al presionar “c” ahora se crea un objeto que persiste en el programa, se dibuja bien y se guarda en el vector sin problemas, porque está en el heap y no desaparece al terminar la función. Esto evita los errores que tenías antes con objetos creados en el stack.

- Esto pasa porque ahora el objeto ya no se crea en la pila, que solo dura mientras la función se ejecuta y luego desaparece, sino en la memoria dinámica (heap). Los objetos en el heap se mantienen en memoria hasta que los eliminas con delete. Por eso, guardar un puntero a un objeto del heap en el vector es seguro, ya que la memoria no se borra automáticamente al salir de la función. Así, los objetos se pueden dibujar y usar más adelante sin que haya errores ni comportamientos extraños.

### Actividad 8. 
.h:

```javascript
#pragma once
#include "ofMain.h"

// Clase básica de círculo
class Circle {
public:
    Circle(float x, float y, float r) : x(x), y(y), radius(r) {}
    void draw() const {
        ofDrawCircle(x, y, radius);
    }
    float x, y;
    float radius;
};

// Objeto global (memoria global)
Circle globalCircle(100, 100, 50);

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void mousePressed(int x, int y, int button);
    void keyPressed(int key);

private:
    void createHeapCircle(float x, float y);
    void createStackCircle(float x, float y);

    std::vector<Circle*> heapCircles; // círculos en heap
    std::vector<Circle> stackCircles; // copias de círculos en stack
};

```
.cpp
```javascript
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofBackground(0);
}

//--------------------------------------------------------------
void ofApp::update() {
    // Nada por ahora
}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar círculo global
    ofSetColor(255, 0, 0);
    globalCircle.draw();
    ofDrawBitmapString("Global Circle (siempre existe)", 20, 20);

    // Dibujar círculos en heap
    int yOffset = 50;
    ofSetColor(0, 255, 0);
    for (Circle* c : heapCircles) {
        c->draw();
    }

    // Dibujar círculos en stack
    ofSetColor(0, 0, 255);
    for (Circle& c : stackCircles) {
        c.draw();
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    if (button == OF_MOUSE_BUTTON_LEFT) {
        // Presionar clic izquierdo: crear objeto en heap
        createHeapCircle(x, y);
    }
    else if (button == OF_MOUSE_BUTTON_RIGHT) {
        // Presionar clic derecho: crear objeto en stack
        createStackCircle(x, y);
    }
}

//--------------------------------------------------------------
void ofApp::createHeapCircle(float x, float y) {
    Circle* c = new Circle(x, y, 30);
    heapCircles.push_back(c);
    ofLog() << "Created Heap Circle at: " << c->x << ", " << c->y;
}

//--------------------------------------------------------------
void ofApp::createStackCircle(float x, float y) {
    Circle c(x, y, 30);
    stackCircles.push_back(c); // guardamos copia para poder dibujar después
    ofLog() << "Created Stack Circle at: " << c.x << ", " << c.y;
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'g') {
        // Mover el círculo global a una posición aleatoria
        globalCircle.x = ofRandom(50, ofGetWidth() - 50);
        globalCircle.y = ofRandom(50, ofGetHeight() - 50);
        ofLog() << "Moved Global Circle to: " << globalCircle.x << ", " << globalCircle.y;
    }
}


```
 | Tipo de almacenamiento | Qué ocurre                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Heap** (`new`)       | Los objetos persisten en memoria hasta que los elimines con `delete`. Puedes crear muchos objetos dinámicamente y acceder a ellos en cualquier momento. |
| **Stack** (local)      | Los objetos solo existen mientras dura la función que los creó. Si quieres usarlos después, necesitas **copiarlos** a otro lugar.                       |
| **Global**             | Los objetos existen durante toda la ejecución del programa. Útiles si siempre necesitas acceso a ellos.                                                 |


### Actividad 9.

- Cuando presiono la tecla “f”, el programa revisa si hay objetos en heapObjects. Si hay al menos uno, elimina el último círculo azul que creé con el mouse, liberando la memoria que estaba ocupando en el heap. Después quita el puntero del vector, así el objeto desaparece y no se dibuja más en pantalla.

- Estas líneas revisan primero si el vector "heapObjects" tiene al menos un objeto. Si es así, toma el último objeto creado en el "heap" y libera la memoria que estaba ocupando con delete. Después quita el puntero del vector con "pop_back", para que ya no esté en la lista ni se dibuje más. Así me aseguro de que no queden objetos ocupando memoria innecesariamente y evito errores.