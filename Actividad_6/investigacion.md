# Sesión 2  
## Observer  
se encuentra en el ofapp.h:  
```
class Observer {                                  
public:
    virtual void onNotify(const std::string& event) = 0;   
};

class Subject {                                  
public:
    void addObserver(Observer* observer);         
    void removeObserver(Observer* observer);      
protected:
    void notify(const std::string& event);       
private:
    std::vector<Observer*> observers;            
};

// Particle implementa Observer
class Particle : public Observer {                
    void onNotify(const std::string& event) override; 
};  
```
y en el .cpp, osea la implementación:
```
void Subject::addObserver(Observer* observer) {
    observers.push_back(observer);
}

void Subject::removeObserver(Observer* observer) {
    observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) {
    for (Observer* observer : observers) {
        observer->onNotify(event);
    }
}

void ofApp::keyPressed(int key) {                         
    if (key == 's') notify("stop");                        
    else if (key == 'a') notify("attract");
    else if (key == 'r') notify("repel");                 
    else if (key == 'n') notify("normal");                
}
```  
Observer permite que las partículas (que son observadores) “escuchen” los eventos que lanza el ofApp (que es el sujeto).
Ósea , el programa no cambia el estado de cada partícula una por una, sino que el ofApp lanza un mensaje con notify("attract") y automáticamente todas las partículas que están registradas reciben ese evento en su función onNotify.

## Factory:  
OfApp.h:
```  
class ParticleFactory {
public:
    static Particle* createParticle(const std::string& type);
};
```  
OfApp.cpp:
``` 
Particle* ParticleFactory::createParticle(const std::string& type) {
    Particle* particle = new Particle();

    if (type == "star") {
        particle->size = ofRandom(2, 4);
        particle->color = ofColor(255, 0, 0);
    }
    else if (type == "shooting_star") {
        particle->size = ofRandom(3, 6);
        particle->color = ofColor(0, 255, 0);
        particle->velocity *= 3;
    }
    else if (type == "planet") {
        particle->size = ofRandom(5, 8);
        particle->color = ofColor(0, 0, 255);
    }
    return particle;
}
```
```     
// ofApp.cpp (setup)
Particle* p = ParticleFactory::createParticle("star");           
Particle* p = ParticleFactory::createParticle("shooting_star");  
Particle* p = ParticleFactory::createParticle("planet");         
```   
Factory se encarga de crear partículas diferentes según el tipo. En lugar de estar escribiendo new Particle() en todas partes y luego configurarle manualmente tamaño y color, el Factory ya sabe qué propiedades asignar a una partícula tipo "star", "shooting_star" o "planet".

## State   
```
class State {
public:
    virtual void update(Particle* particle) = 0;
    virtual void onEnter(Particle* particle) {}
    virtual void onExit(Particle* particle) {}
    virtual ~State() = default;
};
class NormalState : public State {
public:
    void update(Particle* particle) override;
    virtual void onEnter(Particle* particle) override;
};


class AttractState : public State {
public:
    void update(Particle* particle) override;
};

class RepelState : public State {
public:
    void update(Particle* particle) override;
};

class StopState : public State {
public:
    void update(Particle* particle) override;
};

class ParticleFactory {
public:
    static Particle* createParticle(const std::string& type);
};

State* state;                        
void setState(State* newState);
```    
``` 
oid Particle::onNotify(const std::string& event) {
    if (event == "attract") {
        setState(new AttractState());
    }
    else if (event == "repel") {
        setState(new RepelState());
    }
    else if (event == "stop") {
        setState(new StopState());
    }
    else if (event == "normal") {
        setState(new NormalState());
    }
}

void NormalState::update(Particle* particle) {
    particle->position += particle->velocity;
}

void NormalState::onEnter(Particle* particle) {
    particle->velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
}

void AttractState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = mousePosition - particle->position;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void RepelState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = particle->position - mousePosition;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}
```   
State controla cómo se comporta una partícula dependiendo del estado en que esté. Por ejemplo:

- En NormalState se mueven de forma aleatoria.

- En AttractState son atraídas al mouse.

- En RepelState huyen del mouse.

- En StopState se detienen completamente.

Cada partícula puede cambiar de estado con setState(new AttractState()) cuando recibe un evento, y así su lógica de movimiento cambia sin modificar la clase Particle directamente.

## Resumen   

| Patrón | Función en el programa |
| --- | --- |
| **Observer** | Hace que todas las partículas escuchen los eventos del `ofApp` y cambien de estado al mismo tiempo. |
| **Factory** | Crea partículas de diferentes tipos ya configuradas (estrella, estrella fugaz, planeta). |
| **State** | Cambia el comportamiento de cada partícula según su modo (normal, atraer, repeler, detener). |