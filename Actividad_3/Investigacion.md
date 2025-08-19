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



- Codigo:

h.

#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:

        vector<ofVec2f> particles;
        vector<Particle> particles;
        ofColor particleColor;

};


.cpp

#include "ofApp.h"
struct Particle {
    ofVec2f pos;
    float alpha;
};

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    particleColor = ofColor::white;
}

//--------------------------------------------------------------
void ofApp::update(){
    for(auto &p: particles){
        p.alpha -= 2; // se desvanece poco a poco
        if(p.alpha < 0) p.alpha = 0;
    }

    // que el rastro sea más corto con el tiempo
    if(particles.size() > 80){ // antes 100
        particles.erase(particles.begin());
    }
}



//--------------------------------------------------------------
void ofApp::draw(){
    for(auto &p: particles){
        ofSetColor(particleColor, p.alpha); // color con transparencia
        ofDrawCircle(p.pos.x, p.pos.y, 50);
    }
}


//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
    Particle p;
    p.pos = ofVec2f(x, y);
    p.alpha = 255; // empieza totalmente visible
    particles.push_back(p);

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}


## ACtividad 5. 
- 1. Un puntero es una variable que almacena la dirección de memoria de otra variable u objeto, en lugar de almacenar el valor directamente. Permite acceder y manipular datos indirectamente.  

- 2. En el código hay dos punteros:

    - "vector<Sphere*> spheres" - Un vector de punteros a objetos Sphere

    - "Sphere* selectedSphere "- Un puntero individual a un objeto Sphere

    Ambos están declarados en la clase "ofApp" como miembros privados.

- 3. En el código mostrado no se ve la inicialización, pero típicamente se haría:
    // En ofApp::setup() o constructor
    selectedSphere = nullptr; // Inicialización a null

    // O asignando la dirección de un objeto existente
    selectedSphere = new Sphere(x, y, radius);
    // O selectedSphere = &algunaEsferaExistente;

- 4. Los punteros se usan para:

     - spheres: Almacenar dinámicamente múltiples objetos Sphere sin copiarlos
     - selectedSphere: Mantener una referencia a una esfera específica (probablemente para arrastrarla o manipularla)

- 5. Los punteros almacenan:

        - Direcciones de memoria donde se encuentran los objetos Sphere

        - NO almacenan los objetos mismos, solo referencias a ellos

        - "selectedSphere" almacena 0 (nullptr) o la dirección de una esfera existente


## Actividad 6.

AL codigo le hace falta la lógica para seleccionar y arrastrar esferas. Por lo tanro el código actual:

- Crea esferas al hacer click 

- Las dibuja 

PERO, no detecta cuándo clickeas sobre una esfera existente, ni Permite arrastrar la esfera seleccionada
- punteros no inicializados
    Sphere* selectedSphere; // no inicializado  

- Se duplican las clases
// ofApp.h
#pragma once
#include "ofMain.h"

class Sphere {  
    // ...
};

// ofApp.cpp  
#include "ofApp.h"  

// NO debe repetir las declaraciones
class Sphere {  // Esto no deberia de ir 
    // ...
};

- Flata de gestion de memoria:
    vector<Sphere*> spheres; 
    // Se crean con 'new' pero NUNCA se liberan → **memory leak**  

-   Lógica de Selección Inexistente  

    void mousePressed(int x, int y, int button) {
    // SOLO crea esferas, NO detecta selección
    spheres.push_back(new Sphere(x, y, ofRandom(20, 50)));
    // No verifica si clickeó sobre esfera existente
    }

- Movimiento No Implementado
    void mouseMoved(int x, int y) {
    // Función vacía - no mueve esferas seleccionadas
    }

- Métodos Faltantes en Sphere
    class Sphere {
    // Falta método para detectar colisión con punto
    // bool contains(float x, float y);
    };

-  Falta Destructor
    class ofApp {
    // No tiene destructor para liberar memoria
    // ~ofApp();
    };

- No hay muestras al usuario
    void draw() {
    // No muestra qué esfera está seleccionada
    // No da feedback visual al usuario
    }


ofApp.h:
#pragma once
#include "ofMain.h"

class Sphere {
public:
    Sphere(float x, float y, float radius);
    void draw();
    void update(float x, float y);
    bool contains(float pointX, float pointY);
    float getX();
    float getY();
    float getRadius();

private:
    float x, y;
    float radius;
    ofColor color;
};

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void mouseMoved(int x, int y);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    ~ofApp(); // Destructor

private:
    vector<Sphere*> spheres;
    Sphere* selectedSphere;
    bool isDragging; // Nuevo: estado de arrastre
};

ofapp.cpp
#include "ofApp.h"

Sphere::Sphere(float x, float y, float radius) 
    : x(x), y(y), radius(radius) {
    color = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

void Sphere::draw() {
    ofSetColor(color);
    ofDrawCircle(x, y, radius);
    ofSetColor(0);
    ofDrawCircle(x, y, 2); // Punto central para referencia
}

void Sphere::update(float x, float y) {
    this->x = x;
    this->y = y;
}

bool Sphere::contains(float pointX, float pointY) {
    float distance = sqrt(pow(pointX - x, 2) + pow(pointY - y, 2));
    return distance <= radius;
}

float Sphere::getX() { return x; }
float Sphere::getY() { return y; }
float Sphere::getRadius() { return radius; }

// Implementación de ofApp
void ofApp::setup() {
    selectedSphere = nullptr;
    isDragging = false;
}

void ofApp::update() {
    // Lógica de actualización si es necesaria
}

void ofApp::draw() {
    ofBackground(50);
    
    for (auto sphere : spheres) {
        sphere->draw();
    }
    
    // Dibujar info de selección
    if (selectedSphere) {
        ofSetColor(255, 255, 0);
        ofNoFill();
        ofDrawCircle(selectedSphere->getX(), selectedSphere->getY(), 
                    selectedSphere->getRadius() + 2);
    }
}

void ofApp::mouseMoved(int x, int y) {
    if (isDragging && selectedSphere) {
        selectedSphere->update(x, y);
    }
}

void ofApp::mousePressed(int x, int y, int button) {
    if (button == OF_MOUSE_BUTTON_LEFT) {
        // Verificar si clickeó sobre una esfera existente
        selectedSphere = nullptr;
        for (int i = spheres.size() - 1; i >= 0; i--) {
            if (spheres[i]->contains(x, y)) {
                selectedSphere = spheres[i];
                isDragging = true;
                break;
            }
        }
        
        // Si no clickeó sobre esfera existente, crear nueva
        if (!selectedSphere) {
            Sphere* newSphere = new Sphere(x, y, ofRandom(20, 40));
            spheres.push_back(newSphere);
        }
    }
}

void ofApp::mouseReleased(int x, int y, int button) {
    if (button == OF_MOUSE_BUTTON_LEFT) {
        isDragging = false;
    }
}

ofApp::~ofApp() {
    for (auto sphere : spheres) {
        delete sphere;
    }
    spheres.clear();
}