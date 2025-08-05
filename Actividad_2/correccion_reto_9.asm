// Main
@6
D=A
@a
M=D     //guardar a=6
@9
D=A
@b
M=D     //guardar b=9

@SUMA       //saltar a la función suma 
0;JMP

(SUMA)
@a
D=M     // D = a
@b
D=D+M       // D=a+b
@c
M=D         // guardar resultado en c (RAM[26])
@END
0;JMP       //volver al "main"

// aquí se asume que la función dejará el resultado en RAM[26] (c)
(END)
@END
0;JMP      // regreso al flujo principal (como si fuera return)WS
