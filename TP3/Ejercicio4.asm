#  $t0 va marcando el indice
add $t0, $t0, $zero
# $s0 indica las N posiciones
addi $t1, $zero, 10
# $t2 son las posiciones de memoria
addi $t2, $zero, 0
loop:
	sw $t0, 0($t2)
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	bne $t0, $t1, loop

exit: j exit
