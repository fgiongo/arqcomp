.data 
	vetor: .word 36, 2, 27, 29, 51, 17, 5, 81, 9 
	tam: .word 9
	
.text 
	la $s0, vetor  
	lw $s1, tam 	
	
	addi $a0, $s0, 0
	addi $a1, $s1, 0
			
	addi $sp, $sp, -8
	sw $s0, 0($sp)    
	sw $s1, 4($sp)	  
	
	jal bubbleSort    

	lw $s0, 0($sp) 
	lw $s1, 4($sp) 
	addi $sp, $sp, 8 
	
	j exit

bubbleSort:
	
	li $t0, 0 			# i		
ini_do: 
# do {
	li $t1, 0			# trocado
	addi $t0, $zero, 0		# i = 0
ini_for:
	addi $t2, $t0, 0 		# t2 = i
	sll $t2, $t2, 2			# t2 = i (deslocamento em bytes)
	add $t3, $a0, $t2 		# t3 = &A[i]
	
	addi $t2, $t0, 1 		# t2 = i + 1
	sll $t2, $t2, 2			# t2 = i + 1 (deslocamento em bytes)
	add $t4, $a0, $t2 		# t4 = &A[i+1]

	lw $t2, 0($t3)			# tmp = A[i]
	lw $t5, 0($t4)			# t5 = A[i+1]	
	ble $t2, $t5, fim_for
## if A[i] > A[i+1]?
	sw $t5, 0($t3)			# A[i] = A[i+1]
	sw $t2, 0($t4)			# A[i+1] = tmp
	addi $t1, $zero, 1		# trocado = 1
# else
fim_for:
	addi $t0, $t0, 1		# i += 1
	addi $t2, $a1, -1		# t2 = tam - 1
	blt $t0, $t2, ini_for		# if (i < tam - 1)
	bnez $t1, ini_do		# goto do {}							
	jr $ra				# else return

exit:
