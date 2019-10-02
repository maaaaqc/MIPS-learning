#####################################################
#                                                   #
#                    Text Segment                   #
#                                                   #
#####################################################
	.text 
	.globl start
start:	
	lw $t0, sum
	li $t1, 0
	li $t2, 10
	la $s0, array		# Stores address of the first byte
	addi $s1, $s0, 40	# Stores address of the last byte
	la $s2, sum
loop:	
	beq $t1, $t2, end
	la $a0, prompt
	li $v0, 4
	syscall			# Prints the prompt
	li $v0,5
	syscall			# Fetches the input
	sw $v0, ($s0)		# Stores the input into array
	addi $s0, $s0, 4
	addi $t1, $t1, 1
	j loop			# Jumps back to the top
end:	
	subi $s0, $s0, 40 
	jal summation
	li $v0, 4
	la $a0, alert
	syscall			# Prints "the sum is"
	li $v0, 1
	move $a0, $t0
	syscall			# Prints the result
	sw $t0, ($s2)		# Saves the result into "sum"
	li $v0, 10		
	syscall			# Terminates the program
summation: 
	subi $sp, $sp, 8
	sw $ra, 4($sp)
	sw $s0, 0($sp)
	bne $s0, $s1, L1	# Jumps to L1 before finishing the iteration
	addi $sp, $sp, 8
	jr $ra
L1:
	addi $s0, $s0, 4
	jal summation		# Recurses back to summation
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8
	lw $t3, ($s0)
	add $t0, $t0, $t3	# Calculates the sum
	jr $ra

#####################################################
#                                                   #
#                    Data Segment                   #
#                                                   #
#####################################################
	.data
sum:	.word 0
array:	.space 40
prompt: .asciiz "enter a number: \n"
alert:	.asciiz "the sum is: \n"