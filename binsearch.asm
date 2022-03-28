.data
array:	.word	7, 6, 5, 4, 3, 2, 1
length:	.word	7
x:	.word	8
.text
.globl main

binsearch:
#load arr, x, n
lw $s0, 0($sp) # n
addi $sp, $sp 4

lw $s1, 0($sp) # x
addi $sp, $sp 4

lw $s2, 0($sp) # arr
addi $sp, $sp 4

subu $sp, $sp, 16
sw $ra, 0($sp)

#if n==0 return -1, base case
beq $s0, $zero, zero_length


srl $s7, $s0, 1	# s7 = n = n/2
addi $s4, $zero, 4	
mul $s4, $s7, $s4

add $s2, $s2, $s4	#shift to arr[n/2]
lw $s5, 0($s2)

#if x== arr[n/2]
beq $s1, $s5 equal

# arr[n/2] > x
bgt $s5, $s1, greater

# arr[n/2] < x
blt $s5, $s1, less_than



equal: #n==arr[n/2]
	add $v0, $zero, $s7
	j return

greater: #arr[n/2] > x
	#addi $s6, $s0, 4 #index = n/2 +1
	#size: n - n/2 - 1
	sub $s7, $s0, $s7 
	addi $s7, $s7, -1  
	
	addi $s2, $s2, 4 #
	#go right
	addi $sp, $sp, -4 #arr
	sw $s2, 0($sp)
	addi $sp, $sp, -4 #x
	sw $s1, 0($sp)
	addi $sp, $sp, -4 #n
	sw $s7, 0($sp)
		
	jal binsearch
	lw $v0, 0($sp) #get result
	addi $sp, $sp, 4
	beq $v0, -1, zero_length #not found

	#found
	addi $v0, $v0, 1
	
	#need n/2
	lw $s0, 4($sp)
	srl $s0, $s0, 1
	add $v0, $s0, $v0
	
	j return
	
	
	

less_than: #arr[n/2] < x
	lw $s2, 12($sp)
	addi $sp, $sp, -4 #arr
	sw $s2, 0($sp)
	addi $sp, $sp, -4 #x
	sw $s1, 0($sp)
	addi $sp, $sp, -4 #n
	sw $s7, 0($sp)
	jal binsearch
	lw $v0, 0($sp) #get result
	addi $sp, $sp, 4

	j return
	
		


zero_length: #n==0
	addi $v0, $zero, -1

return:
	lw $ra, ($sp)
	addu $sp, $sp, 12
	sw $v0, 0($sp)
	jr $ra
	

main:

	#load arr, x, n
	la $t1, array
	lw $t2, x
	lw $t3, length

	#push arr, x and n
	
	
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	addi $sp, $sp, -4
	sw $t3, 0($sp)
	
	jal binsearch
	lw $t0, 0($sp)
	addi $sp, $sp, 4
	
