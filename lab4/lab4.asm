andi $r2, $r2, 0
addi.w $r2, $r2, 9
andi $r1, $r1, 0
andi $r3, $r3, 0
andi $r4, $r4, 0
andi $r5, $r5, 0
addi.w $r3, $r3, 1
addi.w $r4, $r4, 1
addi.w $r1, $r1, 2
a: 
bge $r1, $r2, exit
addi.w $r5, $r4, 0
addi.w $r4, $r3, 0
add.w $r3, $r4, $r5
addi.w $r1, $r1, 1
b a
exit: 
addi.w $r3, $r3, 0