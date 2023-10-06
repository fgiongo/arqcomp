.data
array: .word 64, 25, 12, 22, 11

.text

la $a0, array  #endereço base do array
li $a1, 5 
jal selectionSort
j exit_program

selectionSort:

#variáveis
# $s0 : i
# $s1 : j
# $s2 : min_index
# $s3 : temp

move $s0, $zero
move $s1, $zero
subi $t0, $a1, 1

first_loop_condition:
slt $t1, $s0, $t0
beq $t1, $zero, exit_loop_ext
move $s2, $s0

addi $s1, $s0, 1
#second loop

second_loop_condition:
slt $t1, $s1, $a1
beq $t1, $zero, exit_inner_loop

sll $t2, $s1, 2    
add $t2,$t2, $a0  
sll $t3, $s2, 2
add $t3, $t3, $a0 
lw $t4, 0($t2) #array[j]
lw $t5, 0($t3) #array[min_index]

#if
slt $t1, $t4, $t5
bne $t1, $zero, update_min_index 

j else

update_min_index:
move $s2, $s1

else:
addi $s1, $s1, 1
j second_loop_condition

exit_inner_loop:
sll $t2, $s0, 2    
add $t2,$t2, $a0  
sll $t3, $s2, 2
add $t3, $t3, $a0 
lw $t4, 0($t2) #array[i]
lw $s3, 0($t3) #array[min_index]
sw $t4, 0($t3)
sw $s3, 0($t2)


addi $s0, $s0, 1
j first_loop_condition

exit_loop_ext:
jr $ra

exit_program:
