// Guardar a = 6
@6
D=A
@24      // a se almacena en la dirección 24
M=D

// Guardar b = 9
@9
D=A
@25      // b se almacena en la dirección 25
M=D

// Simular la función suma: var = a + b
@24
D=M      // D = a
@25
D=D+M    // D = a + b

// Guardar el resultado en c
@26      // c en dirección 26
M=D
