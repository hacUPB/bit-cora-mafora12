## sesion 1
- La clase Particle representa el plano o el molde de una partícula. Ahí defino qué datos va a tener (en este caso x e y, que son su posición) y qué puede hacer (como el método move para moverse). No es un objeto en sí, sino la plantilla que me permite crear muchos objetos Particle, cada uno con sus propios valores de x e y, pero todos compartiendo el mismo comportamiento.

- En mi clase Particle, los atributos x e y representan el estado o la posición de la partícula. Los métodos son las funciones que interactúan directamente con esos atributos: algunos los leen y otros los modifican.
Por ejemplo, el método move(dx, dy) usa el valor actual de x e y y les suma los desplazamientos para cambiar la posición de la partícula. Es decir, los métodos se encargan de transformar o consultar el estado que guardan los atributos.

- Sí, al imprimir las direcciones de p1.x y p1.y me doy cuenta de que están uno al lado del otro en memoria. Los atributos se guardan de forma contigua en memoria (aunque puede haber pequeños espacios de alineación).

- El tamaño del objeto refleja la suma de sus atributos más cualquier relleno interno que agregue el compilador.

- Los datos estáticos no afectan a la instancia en si porque no pertenecen a cada objeto, sino que se guardan una sola vez en la clase (espacio global compartido).

- Los datos dinámicos solo ocupan en el objeto el tamaño del puntero, mientras que la memoria real que se reserva con new vive aparte en el heap y hay que liberarla con el destructor delete.

### Reflexión 

- Un espacio reservado donde se guardan los valores de sus atributos. Cada objeto tiene su propia copia de esos datos, mientras que los métodos no ocupan espacio dentro de él porque se comparten entre todas las instancias.    

- Los atributos influyen en el tamaño porque cada objeto necesita espacio para guardar sus propios valores. En cambio, los métodos no afectan el tamaño del objeto, ya que son funciones compartidas por todas las instancias y no se guardan dentro de cada una. 

### Conclusión 
Entendí que el tamaño de un objeto depende de sus atributos, mientras que los métodos no ocupan espacio dentro de él. Esto me muestra que al diseñar clases debo pensar bien qué datos realmente necesita guardar cada instancia y qué puedo manejar como estático o compartido para no desperdiciar memoria.