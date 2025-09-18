## sesion 1
- La clase Particle representa el plano o el molde de una partícula. Ahí defino qué datos va a tener (en este caso x e y, que son su posición) y qué puede hacer (como el método move para moverse). No es un objeto en sí, sino la plantilla que me permite crear muchos objetos Particle, cada uno con sus propios valores de x e y, pero todos compartiendo el mismo comportamiento.

- En mi clase Particle, los atributos x e y representan el estado o la posición de la partícula. Los métodos son las funciones que interactúan directamente con esos atributos: algunos los leen y otros los modifican.
Por ejemplo, el método move(dx, dy) usa el valor actual de x e y y les suma los desplazamientos para cambiar la posición de la partícula. Es decir, los métodos se encargan de transformar o consultar el estado que guardan los atributos.

- Sí, al imprimir las direcciones de p1.x y p1.y me doy cuenta de que están uno al lado del otro en memoria. Eso pasa porque C++ guarda los atributos de una clase de forma secuencial (aunque a veces puede haber pequeños espacios de relleno por alineación).  

- Cuántos bytes ocupa cada objeto de esa clase en memoria. Ese valor incluye la suma de sus atributos y también posibles bytes extra de alineación que el compilador agrega para que el acceso a memoria sea más eficiente. En este caso, el tamaño refleja directamente que Particle solo guarda dos double (uno para x y otro para y) organizados dentro del objeto.