// Punto 1
@1978
D=A

// Punto 2
@69
D=A
@100
M=D

//Punto 3

@24
D=M
@200
M=D

//Punto 4
@100
D=M
@15
D=D-A
@100
M=D

//Punto 5

@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D

//Punto 6

@100
D;JEQ

//Punto 7

@100
D=M
@100
D=D-A
@20
D;JLT

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

- Optimizado:
@i
M=M+1

//Punto 10

@R0 
D=M
@R0
D=D+M 
@R1 
M=D

//Punto 11


