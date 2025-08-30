1. 
# .h:  

``` js
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    // Ciclo de vida
    void setup() override;
    void update() override;
    void draw() override;

    // Interacción
    void keyPressed(int key) override;
    void mousePressed(int x, int y, int button) override;
    void windowResized(int w, int h) override;

private:
    // ---- Helpers (funciones auxiliares)
    void rebuildGrid(); // recalcula todas las posiciones
    void convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd);
    bool rayIntersectsSphere(const glm::vec3& rayStart,
                             const glm::vec3& rayDir,
                             const glm::vec3& sphereCenter,
                             float sphereRadius,
                             float& outT,
                             glm::vec3& outPoint);

    // ---- Estado de la escena
    ofEasyCam cam;                         // Cámara 3D (MIEMBRO: vive donde viva ofApp)
    std::vector<glm::vec3> spherePositions;// Buffer dinámico con las posiciones (HEAP interno)

    // Parámetros controlados por teclado (MIEMBROS, ver memoria más abajo)
    int   xStep = 20;
    int   yStep = 20;
    float distDiv = 50.f;
    float amplitude = 150.f;
    float sphereRadius = 5.f;

    // Selección
    bool sphereSelected = false;
    int  selectedIndex = -1; // índice en spherePositions (si hay selección)
};
```


# .cpp:  

``` js
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetWindowTitle("Grid de esferas + seleccion con raycasting");
    ofSetFrameRate(60);
    ofBackground(210);
    ofEnableDepthTest();     // necesario para dibujar 3D correctamente
    cam.setDistance(600);    // distancia inicial de la camara
    cam.setNearClip(0.1f);
    cam.setFarClip(5000.f);

    rebuildGrid();
}

//--------------------------------------------------------------
void ofApp::update() {
    // No necesitamos lógica en update para este ejemplo
}

//--------------------------------------------------------------
void ofApp::draw() {
    cam.begin();

    // Dibujar todas las esferas
    // Coloreamos por altura (z) para que se parezca al ejemplo.
    for (size_t i = 0; i < spherePositions.size(); ++i) {
        const glm::vec3& p = spherePositions[i];

        // Color por HSB según z
        float h = ofMap(p.z, -std::abs(amplitude), std::abs(amplitude), 0, 255, true);
        ofSetColor(ofColor::fromHsb((unsigned char)h, 255, 255));

        ofDrawSphere(p, sphereRadius);
    }

    // Resaltar seleccionada (si hay)
    if (sphereSelected && selectedIndex >= 0 && selectedIndex < (int)spherePositions.size()) {
        ofSetColor(0); // contorno negro
        ofNoFill();
        ofDrawSphere(spherePositions[selectedIndex], sphereRadius * 1.8f);
        ofFill();
    }

    cam.end();

    // UI
    ofDisableDepthTest();
    ofSetColor(0);
    std::string info;
    info += "FPS: " + ofToString(ofGetFrameRate(), 2) + "\n";
    info += "Step (x,y): " + ofToString(xStep) + ", " + ofToString(yStep) + "\n";
    info += "distDiv: " + ofToString(distDiv, 2) + "\n";
    info += "amplitude: " + ofToString(amplitude, 2) + "\n";
    info += "radius: " + ofToString(sphereRadius, 2) + "\n";
    info += "Controles:\n";
    info += "  Q/E  - step -/+ (x,y)\n";
    info += "  A/D  - distDiv -/+\n";
    info += "  S/W  - amplitude -/+\n";
    info += "  Z/X  - radius -/+\n";
    info += "  Click para seleccionar una esfera\n";
    ofDrawBitmapStringHighlight(info, 18, 24);

    if (sphereSelected) {
        const auto& sp = spherePositions[selectedIndex];
        ofDrawBitmapStringHighlight("Seleccion: idx=" + ofToString(selectedIndex) +
                                    "  pos=(" + ofToString(sp.x,0) + ", " +
                                                  ofToString(sp.y,0) + ", " +
                                                  ofToString(sp.z,0) + ")",
                                    18, 180);
    }
    ofEnableDepthTest();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    switch (key) {
    case 'w': amplitude += 10.f; break;
    case 's': amplitude -= 10.f; break;
    case 'd': distDiv   += 5.f;  break;
    case 'a': distDiv   -= 5.f;  break;
    case 'e': xStep += 2; yStep += 2; break;
    case 'q': xStep -= 2; yStep -= 2; break;
    case 'x': sphereRadius += 0.5f; break;
    case 'z': sphereRadius -= 0.5f; break;
    default: break;
    }

    xStep = std::max(2, xStep);
    yStep = std::max(2, yStep);
    distDiv = std::max(1.f, distDiv);
    amplitude = std::max(0.f, amplitude);
    sphereRadius = std::max(0.5f, sphereRadius);

    rebuildGrid();   // recalcula z y recoloca la malla
    sphereSelected = false; // invalidamos selección
    selectedIndex = -1;
}

//--------------------------------------------------------------
void ofApp::mousePressed(int mx, int my, int button) {
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(mx, my, rayStart, rayEnd);

    glm::vec3 dir = glm::normalize(rayEnd - rayStart);

    // Buscamos la interseccion mas cercana (t minimo positivo)
    bool found = false;
    float bestT = std::numeric_limits<float>::max();
    int bestIdx = -1;
    glm::vec3 bestPoint;

    for (int i = 0; i < (int)spherePositions.size(); ++i) {
        glm::vec3 point;
        float t;
        if (rayIntersectsSphere(rayStart, dir, spherePositions[i], sphereRadius, t, point)) {
            if (t > 0.f && t < bestT) { // la mas cercana delante de la camara
                bestT = t;
                bestIdx = i;
                bestPoint = point;
                found = true;
            }
        }
    }

    sphereSelected = found;
    selectedIndex  = found ? bestIdx : -1;
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {
    // Recalculamos para que la malla siempre llene la ventana
    rebuildGrid();
}

//--------------------------------------------------------------
// Re-construye la malla de posiciones en una grilla centrada
void ofApp::rebuildGrid() {
    spherePositions.clear();
    spherePositions.reserve((ofGetWidth() / xStep + 2) * (ofGetHeight() / yStep + 2));

    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitude;
            spherePositions.emplace_back((float)x, (float)y, z);
        }
    }
}

//--------------------------------------------------------------
// Convierte el mouse 2D a un rayo en coordenadas de mundo
void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    float x = 2.f * (mouseX - viewport.x) / viewport.width - 1.f;
    float y = 1.f - 2.f * (mouseY - viewport.y) / viewport.height;

    glm::vec4 rayStartNDC(x, y, -1.f, 1.f);
    glm::vec4 rayEndNDC  (x, y,  1.f, 1.f);

    glm::mat4 inv = glm::inverse(projection * modelview);
    glm::vec4 startWorld = inv * rayStartNDC;
    glm::vec4 endWorld   = inv * rayEndNDC;

    startWorld /= startWorld.w;
    endWorld   /= endWorld.w;

    rayStart = glm::vec3(startWorld);
    rayEnd   = glm::vec3(endWorld);
}

//--------------------------------------------------------------
// Intersección rayo-esfera. Devuelve true/false y el t de la intersección más cercana
bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart,
                                const glm::vec3& rayDir,
                                const glm::vec3& sphereCenter,
                                float sphereRadius,
                                float& outT,
                                glm::vec3& outPoint)
{
    glm::vec3 oc = rayStart - sphereCenter;
    float a = glm::dot(rayDir, rayDir);
    float b = 2.f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

    float discriminant = b*b - 4*a*c;
    if (discriminant < 0.f) return false;

    float sqrtDisc = sqrtf(discriminant);
    float t1 = (-b - sqrtDisc) / (2.f * a);
    float t2 = (-b + sqrtDisc) / (2.f * a);

    // Queremos el t positivo mas chico
    float t = std::numeric_limits<float>::max();
    if (t1 > 0.f) t = t1;
    if (t2 > 0.f && t2 < t) t = t2;
    if (t == std::numeric_limits<float>::max()) return false;

    outT = t;
    outPoint = rayStart + t * rayDir;
    return true;
}
```

2.   

En esta aplicación estuve revisando cómo se maneja la memoria y dónde se guardan las cosas principales. No estoy 100% segura de todo, pero esto es lo que entendí después de probar y mirar un poco en el depurador.

-  std::vector<glm::vec3> spherePositions

El vector en sí hace parte de la clase ofApp. Según lo que vi, la estructura del vector (como el tamaño y los punteros internos) se guarda donde está ofApp. Creo que como ofApp lo crea openFrameworks en el heap, entonces el vector también está ahí.

Los elementos (glm::vec3) no están dentro del stack, sino que se guardan en el heap, porque los std::vector reservan memoria dinámica cada vez que crecen.

- Objetos Sphere en globalVector

Aquí fue donde más me enredé al principio. Yo estaba creando las esferas en el stack y guardando su dirección en el vector global, pero después entendí que eso es un problema porque cuando la función termina, esa memoria desaparece. Entonces los punteros quedaban “colgando”.

La solución fue usar std::make_unique, que crea los objetos en el heap y además los maneja automáticamente. Así no tengo que preocuparme por borrarlos manualmente.

- globalVector

Como está declarado afuera de todo, entendí que su estructura vive en la memoria global durante toda la ejecución del programa.
Lo que guarda realmente son punteros (en este caso unique_ptr) que apuntan a objetos que sí están en el heap.

- Miembros de ofApp

Cosas como cam, xStep o sphereRadius son simplemente variables miembro de la clase. Como ofApp la instancia openFrameworks en el heap, pienso que todos estos datos también quedan en el heap.

- Conclusiones  

    - Los vectores guardan sus elementos en el heap, aunque la estructura del vector esté en otra parte (stack, heap o global, según dónde se declare).

    - No se deben guardar direcciones de objetos creados en el stack, porque al salir de la función ya no existen.

    - Con unique_ptr el manejo es mucho más seguro, porque libera la memoria automáticamente.

    - En general, en mi aplicación se usan las tres zonas: heap (vectores y objetos dinámicos), global (estructura de globalVector) y heap de clase (miembros de ofApp).

3.  el video se encuentra dentro de la carpeta nombrada como Actividad_3
<video controls src="video_demostrativo.mp4" title="Title"></video>
