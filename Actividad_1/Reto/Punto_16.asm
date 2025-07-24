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
M=M+1

@LOOP_START
0;JMP

(END)
@END
0;JMP
