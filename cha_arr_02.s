# Read n even number of elements to an un-initialized array, Where n is also user input. Then do the following through a separate function (as explained below)

# Let input n is 8 (This is also user input and must be even other-wise your program should not accept it)
# Then you have to read 8 elements as
# say, 6, 2, 3, 9, 1, 5, 4, 3

# Pass address of the array and n to a function as parameter and the function should process every corresponding pair and store result properly. It should calculate sum and product of the pair and sum must be saved at first position and product must follow it.

# So, after process, the avove array must be

# 8 12 12 27 6 5 7 12
##################################################################

MAX_SIZE = 100

	.text
main:
	addiu $sp, $sp, -4
	sw   $ra, ($sp)
	
	la   $a0, prompt1
	li   $v0, 4
	syscall
	
	li   $v0, 5
	syscall
	move $t0, $v0
	
	rem  $t1, $t0, 2
	beq  $t1, 0, process_code
	
	la   $a0, sorry_result
	li   $v0, 4
	syscall
	b end_part
process_code:
	la   $a0, prompt2_part1
	li   $v0, 4
	syscall
	
	move $a0, $t0
	li   $v0, 1
	syscall
	
	la   $a0, prompt2_part2
	li   $v0, 4
	syscall
	
	li   $t1, 1
	la   $t2, arr
read_loop:
	li   $v0, 5
	syscall
	sw   $v0, ($t2)
	addi $t2, $t2, 4
	addi $t1, $t1, 1
	ble  $t1, $t0, read_loop
	
	la   $a0, arr
	move $a1, $t0
	move $t7, $t0
	
	jal fun
	
	la   $a0, result
	li   $v0, 4
	syscall

	la   $t1, arr
	li   $t2, 1
result_loop:
	lw   $a0, ($t1)
	li   $v0, 1
	syscall
	
	li   $a0, ' '
	li   $v0, 11
	syscall
	addi $t1, $t1, 4
	addi $t2, $t2, 1
	ble  $t2, $t7, result_loop
	
end_part:	

	lw   $ra, ($sp)
	addiu $sp, $sp, 4
	jr	 $ra
	
	.text
fun:
	addiu $sp, $sp, -4
	sw   $ra, ($sp)
	
	move $t0, $a0
	move $t1, $a1
	li   $t2, 1
	
fun_loop:
	lw   $t3, ($t0)
	move $t5, $t0
	addi $t0, $t0, 4
	lw   $t4, ($t0)
	
	add  $t6, $t3, $t4
	mul  $t3, $t3, $t4
	
	sw   $t6, ($t5)
	sw   $t3, ($t0)
	
	addi $t0, $t0, 4
	addi $t2, $t2, 2
	ble  $t2, $t1, fun_loop
	
	lw   $ra, ($sp)
	addiu $sp, $sp, 4
	jr	 $ra
	
	.data
prompt1:
	.asciiz "Type array size: "
prompt2_part1:
	.asciiz "\nType "
prompt2_part2:
	.asciiz "array elements: "
sorry_result:
	.asciiz "Aborted! Your input must be even integer!"
result:
	.asciiz "\nResult array is: "
arr:
	.word MAX_SIZE

