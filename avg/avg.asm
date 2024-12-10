.data
	elements: .float 7.0, 2.0, 5.0, 11.0, 4.0, 6.0, 1.0, 1.0, 8.0, 3.0
	size: .word 10
	sum: .float 0.0
	avg: .float 0.0
	message: .asciiz "Average is: "
	i : .word 0
.text
.globl main

  main:
  	lw $t0, i
  	la $t1, elements
  	lw $t2, size
	l.s $f2, sum
  	loop_start:
  		bgt $t0, $t2, loop_end
  		l.s $f0, 0($t1)
  		add.s $f2, $f2, $f0
  		addi $t1, $t1, 4
  		addi $t0, $t0, 1
  		j loop_start
  	loop_end:
  		mtc1 $t2, $f4
  		cvt.s.w $f4, $f4
  		div.s $f2,$f2 , $f4
  		s.s $f2, avg	
  		la $a0, message
  		li $v0, 4
  		syscall
  		
  		mov.s $f12, $f2
  		li $v0, 2
    		syscall
    		
    		li $v0, 10
    		syscall

  		
  		
