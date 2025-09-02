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