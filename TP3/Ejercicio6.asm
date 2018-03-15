
add $t0, $0, 4
add $t1, $0, 3
add $t3, $0, 0
loop:	
# Restamos a un termino y sumamos 1 vez el otro
	add $t3, $t3, $t0
	sub $t1, $t1, 1
	bne $t1, $0, loop
finish: j finish
