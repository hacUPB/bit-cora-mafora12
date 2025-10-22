
@10
D=A
@var  //indica una dirección en la memoria 
M=D  //var=10 (Guarda el valor de D (10) en la dirección llamada var.)

//*punt=&var 
@var    //apunta
D=A     //Guarda la dirección de var en D, no su valor, solo su ubicación.
@punt 
M=D     // Guarda en punt la dirección de var.

// *punt=20;
@20
D=A
@punt  //Apunta a la variable punt, que contiene la dirección de var.
A=M    // A ahora contiene la dirección guardada en punt (o sea, dirección de var)
M=D    // almacena 20 en la dirección apuntada (var)