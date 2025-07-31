// i = 1
@1
D=A
@i
M=D

// sum = 0
@0
D=A
@sum
M=D

(LOOP)
    // if (i > 100) goto END

    @i
    D=M
    @101      // usamos 101 para hacer "i <= 100", por comparación invertida
    D=D-A     // D = i - 101
    @END
    D;JGE     // si D >= 0 → i >= 101 → salir

    // sum = sum + i
    @sum
    D=M       // D = sum
    @i
    D=D+M     // D = sum + i
    @sum
    M=D       // sum = sum + i

    // i = i + 1
    @i
    M=M+1

    @LOOP
    0;JMP     // volver al inicio del ciclo

(END)
    // fin del programa
    @END
    0;JMP     // bucle infinito para detener 