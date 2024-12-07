.data
Array: .word 10, 31, 5, 7, 11, 3, 8, 40, 12, 4
size: .word 10
outputText: .asciiz"Min element is: "

.text
.globl main
main:
	li $v0, 4
	la $a0, outputText
	syscall
	
	la $t0, Array
	lw $t1, size
	lw $t2, 0 ($t0) #initial min (first in array)

	add $t3, $zero, $zero #loop counter i
For:
	bge $t3, $t1, Exit #if (i >= size) go to Exit:
	lw $t4, 0($t0) #load currnet element
	add $t0, $t0, 4 #increment address by 4
	slt $t5, $t4, $t2 #if ($t4 < $t2) $t5 = 1; else #$t5 = 0 (swap 2 with 4 if you want max)
	#if $t5 = $zero
	beq $t5, $zero, continue
	#else
	move $t2, $t4 #$t2 = $t4 ---> min = Array[i]
continue:
	add $t3, $t3, 1 #i++
	j For #jump to the start of the loop
Exit:
	li $v0, 1
	la $a0, 0($t2)
	syscall



