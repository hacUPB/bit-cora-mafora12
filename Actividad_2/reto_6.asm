//var=10
@10
D=A
@var 
M=D

//bis=5
@5
D=A
@bis 
M=D

// p_var = &var
@var
D=A
@p_var
M=D

@p_var
A=M    // A apunta a la dirección almacenada en p_var (es decir, var)
D=M    // D obtiene el valor en esa dirección (contenido de var)
@bis
M=D    // bis = valor de var