//MAIN:
    // Paso de parámetros a la función suma(a=6, b=9)
    @6
    D=A
    @a         //almacenar a = 6
    M=D

    @9
    D=A
    @b         //almacenar b = 9
    M=D

    //Llamar a la función suma
    @SUMA
    0;JMP

    //El valor devuelto estará en la variable 'ret'
    @ret
    D=M
    @c
    M=D        //c = suma(6, 9)

    
    //Fin del programa
    @END
    0;JMP


(SUMA)
    // var = a + b
    @a
    D=M
    @b
    D=D+M
    @ret
    M=D        //guardar el resultado en 'ret'

    //Retornar al main 
    @MAIN_RETURN
    0;JMP


// Variables simbólicas 
(a)     // a = 6
(b)     // b = 9
(var)   // resultado dentro de suma (puede omitirse)
(ret)   // valor devuelto por suma
(c)     // c en main

(MAIN_RETURN)
@END
0;JMP

(END)
@END
0;JMP    //loop infinito para terminar

