# Reto  
El espacio visual funciona como un paisaje vivo y cambiante.
Cada partícula —que puede ser una hoja, una gota o una semilla— se mueve de forma orgánica y sensible a las acciones del usuario.
Los colores y la energía del entorno cambian dependiendo del estado activo:

- En modo calma, el movimiento es lento y los tonos son suaves.

- En modo tormenta, las partículas se agitan con fuerza y los colores se vuelven más intensos.

- En modo crecimiento, nacen nuevas partículas y todo se llena de vida.

- En modo decadencia, las partículas comienzan a desaparecer lentamente.

La intención es que la persona que interactúe sienta que hace parte del sistema, como si sus acciones afectaran directamente el “clima” del ecosistema digital.  

## Aplicación de los Patrones de Diseño
### Observern  
El patrón para que el entorno principal se comunique con todas las partículas.
Cuando ocurre un evento (por ejemplo, un cambio de estado o una acción del usuario), el programa notifica a todas las partículas para que se actualicen.
Así, cada partícula reacciona de manera independiente, pero dentro del mismo sistema.

### Factory  
El patrón Factory para crear distintos tipos de partículas sin tener que cambiar la estructura del código.

Por ejemplo:

- LeafParticle: hojas que flotan.

- RainDrop: gotas que caen.

- Seed: semillas que germinan.

- WindParticle: corrientes de aire que afectan a las demás.

esto me permitira experimentar con diferentes comportamientos y estilos visuales de una forma flexible y ordenada.

### State  
Para representar los diferentes estados del ecosistema.
Cada uno modifica el comportamiento y apariencia general del entorno:

- CalmState → partículas suaves y lentas.

- StormState → movimiento rápido y caótico.

- GrowthState → aparición de nuevas partículas.

- DecayState → partículas que se desvanecen.

Gracias al patrón State pude hacer que el proyecto se sintiera más dinámico y emocional, como si el entorno tuviera “humores” o estados de ánimo.

### Interacción  
Movimiento del mouse: cambia la dirección o la intensidad del flujo de las partículas.  
Teclas:

C → calma.  
T → tormenta.  
G → crecimiento.  
D → decadencia.  

Cada acción provoca una respuesta inmediata, generando una sensación de diálogo entre el usuario y el entorno.