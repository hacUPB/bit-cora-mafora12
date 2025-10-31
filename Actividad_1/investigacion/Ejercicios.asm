@250
D=A
@200
M=D
@200
D=M
@100
M=D
//RAM [3]=250
@250
D=A
@3
M=D
// RAM[3] ← RAM[3] – 15
@15
D=A
@3
M=M-D
// Computes: RAM[2] = RAM[0] + RAM[1] + 17
@0
D=M
@1
D=D+M
@17
D=D+A
@2
M=D

// if (D = 0) goto 300

@300
D;JEQ

// if (RAM[3]<100) goto 12
@100
D=A
@3
D=M-D
@12
D;JLT

