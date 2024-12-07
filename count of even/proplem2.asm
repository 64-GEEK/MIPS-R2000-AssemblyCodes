        .data
arr1:   .word 10, 31, 5, 7, 11, 3, 8, 40, 12, 4
arr2:   .word 19, 2, 3, 7, 5, 10, 9, 0, 6, 1
msg:    .asciiz "Count of even numbers is: "
newline: .asciiz "\n"  # String for newline

        .text
        .globl main

main:
        # First array
        la   $t0, arr1      # Load address of first array into $t0
        li   $t1, 10        # Number of elements in the first array (size)
        li   $t2, 0         # Counter for even numbers, initialized to 0

loop1:
        lw   $t3, 0($t0)    # Load current element from first array into $t3
        andi $t4, $t3, 1    # Check if the number is even
        beq  $t4, $zero, increment_count1

skip_increment1:
        addi $t0, $t0, 4    # Move to the next element in the first array
        subi $t1, $t1, 1    # Decrease the counter (size)
        bnez $t1, loop1     # If we haven't reached the end of the first array, continue
        j print_result1

increment_count1:
        addi $t2, $t2, 1    # Increment the count for even numbers
        j skip_increment1   # Continue to the next element

print_result1:
        li   $v0, 4         # syscall for print_string
        la   $a0, msg       # Load address of the message into $a0
        syscall

        li   $v0, 1         # syscall for print_int
        move $a0, $t2       # Move the count into $a0 for printing
        syscall

        li   $v0, 4         # syscall for print_string (newline)
        la   $a0, newline   # Load the address of the newline string
        syscall

        # Second array
        la   $t0, arr2      # Load address of second array into $t0
        li   $t1, 10        # Number of elements in the second array (size)
        li   $t2, 0         # Reset counter for even numbers

loop2:
        lw   $t3, 0($t0)    # Load current element from second array into $t3
        andi $t4, $t3, 1    # Check if the number is even
        beq  $t4, $zero, increment_count2

skip_increment2:
        addi $t0, $t0, 4    # Move to the next element in the second array
        subi $t1, $t1, 1    # Decrease the counter (size)
        bnez $t1, loop2     # If we haven't reached the end of the second array, continue
        j print_result2

increment_count2:
        addi $t2, $t2, 1    # Increment the count for even numbers
        j skip_increment2   # Continue to the next element

print_result2:
        li   $v0, 4         # syscall for print_string
        la   $a0, msg       # Load address of the message into $a0
        syscall

        li   $v0, 1         # syscall for print_int
        move $a0, $t2       # Move the count into $a0 for printing
        syscall

        li   $v0, 4         # syscall for print_string (newline)
        la   $a0, newline   # Load the address of the newline string
        syscall

        li   $v0, 10        # syscall for exit
        syscall
