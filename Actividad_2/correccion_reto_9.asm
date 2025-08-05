// Guardar a = 6
@6
D=A
@24      // a se almacena en la dirección 24 
M=D     // a está en la dirección RAM[24] y vale 6.

// Guardar b = 9
@9
D=A
@25      // b se almacena en la dirección 25
M=D     //b está en la dirección RAM[25] y vale 9.

// Simular la función suma: var = a + b
@24
D=M      // D = a (D = RAM[24] = 6 (a))
@25
D=D+M    // D = a + b (D = 6(a) + RAM[25] = 6 + 9 = 15)

// Guardar el resultado en c
@26      // c en dirección 26
M=D
