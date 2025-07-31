(LOOP)
  @KBD
  D=M        // Leer lo que hay en el teclado
  @97
  D=D-A
  @DRAW
  D;JEQ      // Si D == 0 (tecla 'a'), ve a DIBUJAR

  // Si no es la tecla 'a', apaga el píxel
  @SCREEN
  M=0
  @LOOP
  0;JMP

(DRAW)
  @SCREEN
  M=-1       // Enciende el primer bloque de píxeles (todos en 1)
  @LOOP
  0;JMP