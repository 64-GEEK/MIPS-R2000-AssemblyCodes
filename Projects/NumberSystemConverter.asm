.data
    currentSystem: .asciiz"\nEnter the current system: "
    newSystem: .asciiz "Enter the new system: "
    number_prompt: .asciiz "Enter the number: "
    result_prompt: .asciiz "The number in the new system: "
    number_size: .space 1000
    baseNum: .space 32  # Array to store digits (32 bytes)
    error_message: .asciiz "\nInvalid Inputs "
    decoration: .asciiz "\n----------------------------------"
.text
.globl main
    main:

    	#printing "Enter the current system: "
        li $v0, 4
        la $a0, currentSystem
        syscall
        #input
        li $v0, 5
        syscall
        move $t0, $v0 #$t0 has the current system
        move $s0, $v0
        
        #printing "Enter the number: "
        li $v0, 4
        la $a0,number_prompt
        syscall
        #input
        li $v0, 8
        la $a0, number_size #has the number to be converted
        li $a1, 1000
        syscall
        
        move $a1, $t0
        jal OtherToDecimal
        move $t0, $v0
        
        #printing "Enter the new system: "
        li $v0, 4
        la $a0, newSystem
        syscall
        #input
        li $v0, 5
        syscall
        move $t2, $v0 #$t2 has the new system
        
        li $v0, 4
        la $a0, result_prompt
        syscall
        
        move $a0,$t0
        move $a1,$t2
        jal DecimalToOther
        
        li $v0, 4
        la $a0, decoration
        syscall
        
        j main # only for repetition (didn't want to terminate)
        
######################################################################################################################################################
OtherToDecimal:
    # get the base from the function call
    la $t3, number_size
    move $t0, $a1
    li $t4, 0# <-- stores length here
returnAddr:
    addiu $sp, $sp, -4  # Move stack pointer
    sw $ra, 0($sp) 
     
find_length:
    lb $t5, 0($t3)
    beqz $t5, continue
    addiu $t4, $t4, 1
    addiu $t3, $t3, 1
    j find_length
    
continue:
    sub $t4, $t4, 2 # <-- subtract 2 because some weird issue happens so we skip additional index
    la $t3, number_size # <-- reload the buffer address
    li $s0, 0 # <-- this is the position for the power {exp}
    li $t9, 0 # < -- final res

reverse_loop:
    bltz $t4, end
    add $t6, $t3, $t4 
    lb $t7, 0($t6)
    sub $t7, $t7, '0' # <-- initial subtraction for 0
    # Validating allowable values
    blt $t7, 0, invalid_input
    blt $t7, 10, valid_digit
    blt $t7, 17, invalid_input
    ble $t7, 22, uppercase_letter
    blt $t7, 49, invalid_input
    ble $t7, 54, lowercase_letter
    j invalid_input

uppercase_letter:
    sub $t7, $t7, 7
    j check_base

lowercase_letter:
    sub $t7, $t7, 39
    j check_base

valid_digit:
    j check_base

check_base:
    bge $t7, $t0, invalid_input
    j continue_loop
    
continue_loop:
    move $a0, $t0 # <-- filling argument registers to make call the power function
    move $a1, $s0 
    jal power
    move $s1, $v0 # <-- moving the result from power to s1
    addi $s0, $s0, 1 # <-- adding 1 to the next power pos (Exp)
    mul $t8, $t7, $s1 # < -- multiple value * base^pos
    add $t9, $t9, $t8 # < -- add to final result
    sub $t4, $t4, 1   # <-- subtract 1 from index
    j reverse_loop	

end:
   lw $ra, 0($sp)
    addiu $sp, $sp, 4
    move $v0, $t9
    jr $ra

        
invalid_input:
    li $v0, 4
    la $a0, error_message
    syscall
    li $v0, 4
    la $a0, decoration
    syscall
    j main

power:
    li $t8, 1
    beq $a1, $zero, end_power

power_loop:
    mul $t8, $t8, $a0
    sub $a1, $a1, 1
    bne $a1, $zero, power_loop

end_power:
    move $v0, $t8
    jr $ra
######################################################################################################################################################
DecimalToOther:
    # Input: $t1 = n, $t2 = base
    # Output: print the converted number
    move $t1, $a0
    move $t2, $a1

    la $t3, baseNum  # Pointer to baseNum array
    li $t4, 0        # Counter (i)

convert_loop:
    # Check if n > 0
    beq $t1, $zero, print_result

    # remainder = n % base
    div $t1, $t2
    mfhi $t5  # $t5 = remainder

    # Convert to character (0-9 or A-F)
    li $t6, 10
    blt $t5, $t6, store_digit

    # Convert to A-F
    addi $t7, $t5, -10  # $t7 = remainder - 10
    addi $t7, $t7, 65   # ASCII 'A'
    sb $t7, 0($t3)      # Store in baseNum[i]
    j increment_index

store_digit:
    addi $t7, $t5, 48   # ASCII '0'
    sb $t7, 0($t3)      # Store in baseNum[i]

increment_index:
    addi $t3, $t3, 1    # Increment pointer
    addi $t4, $t4, 1    # Increment counter (i)

    # n = n / base
    mflo $t1  # $t1 = quotient
    j convert_loop

print_result:
    # Print the number in reverse order
    sub $t3, $t3, 1  # Point to the last valid digit

print_loop:
    blt $t4, 1, end_function  # Exit loop if all digits are printed

    lb $a0, 0($t3)  # Load digit
    li $v0, 11      # Print character syscall
    syscall

    subi $t3, $t3, 1  # Move pointer backward
    subi $t4, $t4, 1  # Decrement counter
    j print_loop

end_function:
    jr $ra
