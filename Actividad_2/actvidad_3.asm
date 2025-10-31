
(LOOP)
  @KBD
  D=M          // Leer la tecla presionada
  @100
  D=D-A
  @DRAW
  D;JEQ        // Si D = 0 → tecla 'd' → dibujar

  @KBD
  D=M
  @0
  D=D-A
  @CLEAR
  D;JEQ        // Si D = 0 → ninguna tecla → borrar

  @LOOP
  0;JMP        // Si otra tecla → volver al loop

(DRAW)
  @SCREEN
  D=A
  @R12
  AD=D+M

  // row 1
  @4
  D=D+A
  A=D-A
  M=D-A
  // row 2
  D=A
  @32
  AD=D+A
  @4
  D=D+A
  A=D-A
  M=D-A
  // row 3
  D=A
  @32
  AD=D+A
  @31
  D=D+A
  A=D-A
  M=D-A
  // row 4
  D=A
  @32
  AD=D+A
  @68
  D=D+A
  A=D-A
  M=D-A
  // row 5
  D=A
  @32
  AD=D+A
  @4
  D=D+A
  A=D-A
  M=D-A
  // row 6
  D=A
  @32
  AD=D+A
  @15600
  D=D+A
  A=D-A
  M=D-A
  // row 7
  D=A
  @32
  AD=D+A
  @17800
  D=D+A
  A=D-A
  M=D-A
  // row 8
  D=A
  @32
  AD=D+A
  @16904
  D=D+A
  A=D-A
  M=D-A
  // row 9
  D=A
  @32
  AD=D+A
  @16392
  D=D+A
  A=D-A
  M=D-A
  // row 10
  D=A
  @32
  AD=D+A
  @24600
  D=D+A
  A=D-A
  M=D-A
  // row 11
  D=A
  @32
  AD=D+A
  @12336
  D=D+A
  A=D-A
  M=D-A
  AD=A+1
  @2
  D=D+A
  A=D-A
  M=D-A
  // row 12
  D=A
  @31
  AD=D+A
  @6368
  D=D+A
  A=D-A
  M=D-A
  // row 13
  D=A
  @32
  AD=D+A
  @28798
  D=D+A
  A=D-A
  M=A-D
  // row 14
  D=A
  @32
  AD=D+A
  @14848
  D=D+A
  A=D-A
  M=A-D
  AD=A+1
  M=1
  // row 15
  D=A
  @31
  AD=D+A
  @32752
  D=D+A
  A=D-A
  M=A-D
  // row 16
  D=A
  @32
  AD=D+A
  @56
  D=D+A
  A=D-A
  M=D-A
  // row 17
  D=A
  @32
  AD=D+A
  @16
  D=D+A
  A=D-A
  M=D-A

  @LOOP
  0;JMP


(CLEAR)
  @SCREEN
  D=A
  @R13
  M=D          // R13 = inicio pantalla (16384)

  @24576
  D=A
  @R14
  M=D          // R14 = final pantalla (24576)

(CLEAR_LOOP)
  @R13           // puntero 
  A=M           // es la especificacion de lo que tinene que hacer 
  M=0          // Apaga píxel actual

  @R13
  M=M+1        // Avanza al siguiente

  @R14
  D=M
  @R13
  D=D-M        // ¿Llegamos al final?

  @CLEAR_LOOP
  D;JGT        // Si no, sigue borrando

  @LOOP
  0;JMP


 