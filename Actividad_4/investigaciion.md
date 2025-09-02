# Actividad 1

1. Una lista enlazada es una estructura de datos en la que cada elemento, llamado nodo, guarda la información que quiero almacenar y también una referencia (o enlace) al siguiente nodo de la lista. Esto hace que los elementos no tengan que estar uno al lado del otro en la memoria, sino que pueden estar en distintas posiciones, siempre y cuando estén conectados entre sí por esos enlaces.

La diferencia con un arreglo es que en un arreglo los elementos sí están guardados de manera contigua en memoria, uno detrás de otro, lo que permite acceder rápidamente a cualquier posición con un índice. En cambio, en la lista enlazada no puedo saltar directo a un elemento específico, sino que debo recorrer los nodos uno a uno hasta llegar al que necesito.  

2. Al ver el código de una lista enlazada en C++, los nodos se vinculan entre sí a través de un puntero. Cada nodo no solo guarda el dato que necesito, sino también un puntero que señala a la dirección de memoria donde está el siguiente nodo. Gracias a esa estructura es posible que la lista se vaya conectando nodo por nodo sin necesidad de que estén en posiciones contiguas en la memoria.

3. En una lista enlazada la memoria se gestiona de forma dinámica. Cada vez que creo un nodo uso el operador new, que aparta espacio en memoria para guardar tanto el dato como el puntero al siguiente nodo. Cuando ya no necesito ese nodo, debo liberarlo con delete, para que la memoria quede disponible y no se desperdicie (esto se conoce como evitar fugas de memoria).

4. La principal ventaja de una lista enlazada frente a un arreglo es que insertar o eliminar elementos en posiciones intermedias es más eficiente, porque no necesito mover todos los demás elementos como pasaría en un arreglo. En la lista simplemente cambio los punteros de los nodos y ya está. En cambio, en un arreglo, al estar los datos en posiciones contiguas de memoria, hay que desplazar varios elementos para mantener el orden, lo que consume más tiempo y recursos.

5. En este código no hay fugas de memoria porque cada vez que la lista se destruye o se limpia se llama a la función clear(), que recorre todos los nodos, los elimina con delete y libera la memoria que ocupaban.
El destructor de la clase LinkedList se encarga de llamar automáticamente a clear() cuando el objeto deja de existir. Eso asegura que aunque yo no llame manualmente a clear(), igual la memoria se libera correctamente y no queda ocupada innecesariamente.
En pocas palabras: el destructor funciona como una garantía de que la memoria que se reservó con new para los nodos será liberada con delete cuando ya no se necesite.  

6. 
Cuando invoco clear() en la lista enlazada ocurre lo siguiente en la memoria, paso a paso:

    - 1. Empiezo con current = head, es decir apunto al primer nodo de la lista (en tu programa normalmente hay varios nodos creados con new).

    - 2. Dentro del bucle guardo la dirección del siguiente nodo: nextNode = current->next. Hago esto antes de borrar para no perder la referencia al resto de la lista.

    - 3. Llamo delete current; — esto ejecuta el destructor de ese Node (aunque esté vacío) y libera la memoria que el nodo ocupaba en el heap. Después de delete la dirección que tenía current ya no es válida.

    - 4. Asigno current = nextNode y repito el proceso con el siguiente nodo.

    - 5. Repito 2–4 hasta que current sea nullptr (ya no quedan nodos).

    -6. Al salir del bucle pongo head = nullptr; tail = nullptr; size = 0; para dejar la lista en estado vacío y evitar que head o tail apunten a memoria liberada.

Consecuencias / puntos importantes:

    - Cada delete devuelve la memoria al allocator; así se evita una fuga de memoria (memory leak).

    - Cualquier puntero externo que apuntara a un nodo borrado queda dangling y no debe usarse.

    - Llamar clear() varias veces es seguro (si la lista ya está vacía no hace nada).

    - El destructor ~LinkedList() llama a clear(), por lo que la limpieza ocurre automáticamente cuando el objeto se destruye.

    - En aplicaciones en tiempo real crear/borrar muchos nodos por frame puede afectar rendimiento o fragmentar la memoria; para eso conviene reutilizar nodos con un object pool.

7.  
 Cuando se agrega un nuevo nodo al final de una lista enlazada, la estructura en memoria cambia de manera puntual. Primero, se reserva espacio dinámicamente (heap) para el nuevo nodo utilizando el operador "new". Ese nodo almacena el valor que quiero guardar y un puntero que inicialmente está vacío (o nullptr) porque aún no está conectado. Luego, el puntero del último nodo de la lista, que antes apuntaba a nullptr, se actualiza para que apunte al nuevo nodo. Así, el nuevo nodo se convierte en el nuevo final de la lista.

 En cuanto al rendimiento, este proceso no siempre es igual de rápido que en un arreglo. Si la lista no tiene un puntero que guarde directamente el último nodo, el programa tiene que recorrer toda la lista desde el inicio hasta el final para poder enlazar el nuevo nodo, lo cual toma tiempo proporcional al número de elementos (O(n)). En cambio, si la lista guarda un puntero al último nodo, la inserción al final es mucho más rápida porque solo requiere actualizar un enlace, lo que toma un tiempo constante (O(1)). Esto muestra que, aunque las listas enlazadas son flexibles, su rendimiento depende de cómo estén implementadas.

8. 
Imagina trabajamos en un sistema donde constantemente necesitamos insertar y eliminar elementos en distintas posiciones, como en una aplicación que maneja una cola de tareas que cambian de orden según su prioridad. En este caso, usar una lista enlazada sería mucho más ventajoso que un arreglo.

La razón principal está en la gestión de memoria: un arreglo necesita un bloque continuo de memoria, lo que puede ser un problema si no sabemos cuántos elementos vamos a manejar, ya que habría que redimensionarlo cada vez que se llene. En cambio, una lista enlazada no necesita espacio continuo, pues cada nodo se guarda en cualquier parte de la memoria y simplemente se conecta con punteros. Esto hace que sea más flexible cuando no conocemos de antemano la cantidad de datos a manejar.

Además, las operaciones de inserción y eliminación en una lista enlazada son más eficientes cuando se realizan en posiciones intermedias. En un arreglo, insertar un elemento en medio implica mover todos los elementos siguientes una posición hacia la derecha, y eliminar uno requiere moverlos hacia la izquierda. En una lista enlazada, basta con ajustar los punteros de los nodos cercanos, sin necesidad de mover el resto de los elementos. Esto representa una gran ventaja en situaciones donde estas operaciones son muy frecuentes.

9. 
Después de aprender sobre el manejo de memoria en listas enlazadas, creo que podría usar este conocimiento para diseñar una estructura de datos a la medida de una aplicación creativa, por ejemplo un programa donde los usuarios creen historias interactivas y se necesite insertar o eliminar partes en cualquier momento. Las listas enlazadas me ayudarían a organizar esos bloques de información sin preocuparme por tener todo en un espacio continuo de memoria. Para que funcione bien, tendría que fijarme en cómo administrar cada nodo: liberar la memoria cuando ya no se use, evitar dejar referencias colgando y, al mismo tiempo, cuidar que las operaciones sean rápidas para no afectar la experiencia del usuario. También pensaría en la forma de recorrer la lista para que el acceso a los datos no sea lento y así lograr que la aplicación sea eficiente y sin fugas de memoria.

10. 
Cuando pienso en las diferencias entre C++ y un lenguaje como C#, lo primero que noto es que en C++ tengo un control total de la memoria. Eso significa que yo decido exactamente cuándo crear y cuándo liberar los nodos de una lista enlazada, lo que me da mucha flexibilidad para optimizar. La ventaja es que puedo diseñar estructuras de datos súper eficientes, evitando desperdicios de memoria y ajustándolas a lo que necesito.

Sin embargo, ese control también tiene un costo: tengo que estar muy pendiente de no olvidarme de liberar memoria, porque si lo hago, puedo causar fugas que hagan que el programa se vuelva lento o consuma más recursos de lo debido. Eso me genera cierta presión, porque cada puntero que manejo es una responsabilidad.

En cambio, con C#, sé que el recolector de basura me respalda. Eso me da tranquilidad, ya que no me preocupo tanto por liberar memoria de forma manual. Pero también siento que pierdo un poco de control: el recolector puede decidir liberar memoria en un momento inesperado y afectar el rendimiento, lo que puede ser frustrante si quiero máxima eficiencia.

Personalmente, me parece que trabajar en C++ me ayuda a entender mejor cómo funciona la memoria de verdad, me hace más consciente de lo que pasa “detrás de escena”. Siento que, aunque es más difícil, me da una base fuerte para después trabajar en lenguajes como C# sin confiarme demasiado en el recolector. En resumen, es un reto que me exige más cuidado, pero también me da un poder que no tendría en otros lenguajes.

11. 
Si pienso en una pieza de arte generativo hecha con listas enlazadas, donde cada nodo representa un elemento en movimiento (como partículas, trazos o figuras que aparecen y desaparecen), tendría varias consideraciones para que la memoria se maneje bien y no se desperdicie:

Liberar nodos cuando ya no son útiles: si un elemento de la animación se sale de la pantalla o cumple su ciclo de vida, debería eliminar su nodo de la lista de inmediato. Eso evita acumular memoria con objetos “muertos” que ya no se ven.

Controlar los ciclos de vida: tendría que diseñar una regla clara de cuándo un nodo nace y cuándo muere. Por ejemplo, un nodo puede durar 3 segundos o cierto número de frames, y al llegar a ese límite se libera.

Reutilización de memoria (pooling): en lugar de crear y destruir nodos todo el tiempo, podría implementar un “pool” donde los nodos eliminados no se borran completamente, sino que se reciclan para nuevos elementos. Esto hace más eficiente el programa y reduce fragmentación de memoria.

Uso de punteros inteligentes (en C++): si lo programara en C++, preferiría usar unique_ptr o shared_ptr en lugar de punteros crudos, para que la liberación de memoria sea más segura y evitar fugas cuando elimino nodos.

Depuración constante: incluiría pruebas de memoria (con herramientas como Valgrind, si usara C++) para asegurarme de que no queden fugas escondidas en la animación.

Balance entre estética y eficiencia: como es arte generativo, podría ser tentador dejar que haya muchísimos nodos activos a la vez, pero también pensaría en limitar el número máximo de elementos para que no consuma memoria de forma descontrolada.