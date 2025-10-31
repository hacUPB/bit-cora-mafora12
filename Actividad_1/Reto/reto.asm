// Punto 1
@1978
D=A

// Punto 2
@69
D=A
@100
M=D

//Punto 3

@24
D=M
@200
M=D

//Punto 4
@100
D=M
@15
D=D-A
@100
M=D

//Punto 5

@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D

//Punto 6

@100
D;JEQ

//Punto 7

@100
D=M
@100
D=D-A
@20
D;JLT

// punto 9 Optimizado
@i
M=M+1

//Punto 10

@R0 
D=M
@R0
D=D+M 
@R1 
M=D

// Punto 12  

@R1
D=M
@R2 
D=D+M
@69
D=D+A
@R4 
M=D

//Punto 13  

@R0 
D=M
@POS
D;JGE
@R1 
M=-1
@LOOP
0;JMP 

(POS)
@R1
M=1

(LOOP)
@LOOP 
0;JMP


//Punto 14

@R1 
A=M
D=M
@R4 
M=D

// Punto 15

@R0
D=M
@i 
M=D

(LOOP)
@R1 
D=M
@i 
D=D-M
@END 
D;JEQ

@i 
A=M
M=-1

@i 
M=M+1
@LOOP
0;JMP
(END)



//Punto 16
@0
D=A
@sum
M=D

@0
D=A
@j
M=D

(LOOP_START)
@j
D=M 
@10
D=D-A
@END
D;JGE

@arr
D=A
@j
A=D+M
D=M

@sum
M=D+M

@j 
M=M++1

@LOOP_START
0;JMP

(END)
@END
0;JMP


// Punto 17

@7 
D=D-A
@69
D;JEQ








