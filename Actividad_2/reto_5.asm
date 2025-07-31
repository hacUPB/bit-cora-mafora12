//var=10
@10
D=A
@var 
M=D

//*punt=&var 
@var 
D=A
@punt 
M=D

// *punt=20;
@20
D=A
@punt
A=M    // A ahora contiene la dirección guardada en punt (o sea, dirección de var)
M=D    // almacena 20 en la dirección apuntada (var)