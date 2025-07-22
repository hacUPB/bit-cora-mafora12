Respuestas teoricas de los puntos 8 y 9

//Punto 8

-  ¿Qué hace este programa?
ESto suma el contenido de dos variables (var1, var2) 
y guarda el resultado en una tercera variable (var3)

Basicamente:
1. Carga el valor almacenado en var1 y lo guarda en el registro D.
2. Luego suma ese valor con el contenido de var2 y actualiza D con el resultado.
3. Finalmente, guarda ese resultado en la variable var3.

-  ¿En qué posición de la memoria está var1, var2 y var3? ¿Por qué en esas posiciones?
    - var1 en la posición 16
    - var2 en la posición 17
    - var3 en la posición 18
    Estas posiciónes se dan porque en el lenguaje ensamblador las variables no definidas 
    son asignadas automaticamente a partir de la dirección 16 en la RAM y las guara en suseción,
    ósea 16, 17, 18

// Punto 9

- ¿Qué hace este programa?
    inicia la variable "i" con 1, luego se iniciliza la variable "sum" con 0, Se suma el valor 
    de i al valor de sum y guarda el resultado en sum e incrementa la variable i en 1, paraque
    al final sum quede con el valor de 1 y i con el valor 2

- ¿En qué parte de la memoria RAM está la variable i y sum? ¿Por qué en esas posiciones?
     "i" queda en la posición 16  y  "sum" queda en la posición 17. 
     Porque al ser variables no predefinidas el lenguaje ensamlador las asigna automáticamete
     desde la posición 16 en adelante según la cantidad de variables so predefinidas.


//Punto 11

- ¿Qué hace este programa?

    Este programa es un bucle que inicializa la variable i con 1000 y entra en un ciclo "LOOP" donde si i=0 salta a CONT (osea termina el bucle), si esto no pasa restarle uno a i (i-1) y vuelve al inicio del bucle (goto LOOP)

- ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?

    Como la variable "i" no esta definida  desde antes y se usa por primera vez en el codigo como "@i, esta variable se almacena en la RAM en la dirección 16

- ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`

    Los comentarios en el lenguaje ensamblador no se almacenan solo sirven para ayudar a leer el codigo, por lo tanto el lenguaje los ignora del programa.

- ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?

    La primera instricción de este programa es @1000 (solo es una instrucción), esta instrucción se guarda en la ROM y el lenguaje ensamblador la guarda en la dirección 0 de la ROM.
    
- ¿Qué son CONT y LOOP?

    Son eqtiquetas (Lables) de saltos que se usan para marcar posiciones especificas del programa. así:
    -LOOP: Marca el inicio de un bucle.
    -CONT: Marca el punto al que se debe continuar la ejecución una vez finalizado el bucle.
    Se deben usar como: @LOOP y @CONT para que el programa pueda hacer esa instrucción, y estas estan guardads en la ROM.

- ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?

    "i" es una variable de datos almacenada en la memoria RAM que se modifica durante la ejecución del programa. 
    "cont" es una etiqueta del codigo, almacenada en la ROM que se usa para saber donde debe continuar cuando se termine el bucle.

