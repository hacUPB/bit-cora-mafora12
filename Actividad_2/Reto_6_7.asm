@10
D=A
@var
M=D        // var = 10 (Guarda la variable 10 en var)

@5
D=A
@bis
M=D        // bis = 5 (Guarda el numero 5 en la variable bis)

@var
D=A
@p_var
M=D        // p_var = &var (Guarda la dirección de la variable var en la variable p_var. O sea, p_var funciona como un puntero que apunta a var.)

@p_var      //va a la variable p_var (que contiene la dirección de var).
A=M         //Se mueve a la dirección que está dentro de p_var, es decir, ahora estás en var.
D=M         // cargas el valor de var (que es 10) al registro D.
@bis
M=D        // bis = *p_var (Se le asignas a bis el valor de var.)