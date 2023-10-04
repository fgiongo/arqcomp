.data
arr: .word
84
77
22
44
63
14
94
91
59
 2
 7
75
73
98
17
95
53
66
21
15
30
76
23
65
49
11
74
54
52
64
45
51
26
69
43
92
88
 8
29
60
68
39
 9
80
13
33
50
56
67
 5
 1
55
82
71
81
18
35
 6
 3
12
20
41
40
58
38
32
19
47
70
16
79
10
87
78
 0
96
28
24
85
61
31
97
72
36
90
89
57
27
25
99
86
93
37
42
46
83
 4
34
62
48

.text

la $a0, arr
addi $a1, $zero, 0
addi $a2, $zero, 100
jal quicksort
j exit_program

quicksort:
# Entrada:
# $a0: arr_ptr
# $a1: arr_start
# $a2: arr_end

# Variaveis locais:
# $s0: start
# $s1: end
# $s2: pivot
# $s3: tmp

# Empilhando o endereco de retorno e registradores em uso
addi $sp, $sp, -20
sw $s3, 16($sp)
sw $s2, 12($sp)
sw $s1, 8($sp)
sw $s0, 4($sp)
sw $ra, ($sp)

# Caso base: vetor tem tamanho zero ou 1
sub $t0, $a2, $a1
sle $t1, $t0, 1
beq $t1, 1, quicksort_end

# Caso recursivo: inicializacao de variaveis
# TODO
move $s0, $a1         # start = arr_start;
move $t0, $a2         # end = arr_end - 1;
addi $s1, $t0, -1
move $s2, $s0         # pivot = start;
addi $s0, $s0, 1      # start++;

quicksort_loop:
bge $s0, $s1, quicksort_loop_end    # while (start < end)

# if (arr[start] < arr[pivot])
# Checando condicao de entrada
sll $t0, $s0, 2                     # Offset de start
sll $t1, $s2, 2                     # Offset de pivot
add $t3, $t0, $a0                   # $t3: Endereco de arr[start]
add $t4, $t1, $a0                   # $t4: Endereco de arr[pivot]
lw $t0, ($t3)                       # $t0: Valor de arr[start]
lw $t1, ($t4)                       # $t1: Valor de arr[pivot]
bge $t0, $t1, quicksort_end_if_1

# IF 1:
addi $s0, $s0, 1    # start++;
j quicksort_loop    # continue;

quicksort_end_if_1:

# if (arr[end] >= arr[pivot])
# Checando condicao de entrada 
sll $t2, $s1, 2                     # Offset de end
add $t5, $t2, $a0                   # $t5: Endereco de arr[end]
lw $t2, ($t5)                       # $t2: Valor de arr[end]
blt $t2, $t1, quicksort_end_if_2

# IF 2:
addi $s1, $s1, -1    # end--;
j quicksort_loop     # continue;

quicksort_end_if_2:

# Se chegamos aqui, precisamos fazer uma troca
move $s3, $t0        # tmp = arr[start];
sw $t2, ($t3)        # arr[start] = arr[end];
sw $s3, ($t5)        # arr[end] = tmp;

# E reiniciamos o loop
j quicksort_loop

quicksort_loop_end:

# Se chegamos aqui, entao start == end,
# mas e' possivel que o loop nao tenha sido executado,
# entao precisamo re-calcular os valores
sll $t1, $s2, 2                     # Offset de pivot
sll $t2, $s1, 2                     # Offset de end
add $t4, $t1, $a0                   # $t4: Endereco de arr[pivot]
add $t5, $t2, $a0                   # $t5: Endereco de arr[end]
lw $t1, ($t4)                       # $t1: Valor de arr[pivot]
lw $t2, ($t5)                       # $t2: Valor de arr[end]

# Agora vamos retornar o pivot a sua posicao e aproveitar
# as variaveis start e end para as chamadas recursivas.
# Para retornar o pivor 'a posicao correta,
# precisamos verificar se o conteudo no indice start/end
# e' menor que o pivot ou nao

# if (arr[end] >= arr[pivot])
# Condicao de entrada
blt $t2, $t1, quicksort_else_3    # if (arr[end] >= arr[pivot])

# IF 3:
addi $s1, $s1, -1        # end--;
j quicksort_end_if_3

quicksort_else_3:
addi $s0, $s0, 1         # start++;

quicksort_end_if_3:

# Como o valor de end possivelmente mudou,
# precisamos obter o valor de arr[end] novamente
sll $t2, $s1, 2                     # Offset de end
add $t5, $t2, $a0                   # $t5: Endereco de arr[end]
lw $t2, ($t5)                       # $t2: Valor de arr[end]
move $s3, $t2                       # tmp = arr[end];
sw $t1, ($t5)                       # arr[end] = arr[pivot];
sw $s3, ($t4)                       # arr[pivot] = tmp;

# Agora o pivot esta na posicao correta,
# e vamos chamar a funcao recursivamente

# Precisamos atualizar apenas $a2
# para a primeira chamada recursiva
# mas empilhar o valor de $a1 para
# a segunda chamda recursiva
addi $sp, $sp, -4
sw $a2, ($sp)
move $a2, $s1                      # $a2: end
jal quicksort                      # quicksort(arr, array_start, end);

# Agora, desempilhar $a2 e atualizar $a1
# para a segunda chamada recursiva
lw $a2, ($sp)
addi $sp, $sp, 4
move $a1, $s0                      # $a1: start
jal quicksort                      # quicksort(arr, start, array_end);

quicksort_end:
# Restaurando registradores, desempilhando endereço de retorno e retornando
lw $s3, 16($sp)
lw $s2, 12($sp)
lw $s1, 8($sp)
lw $s0, 4($sp)
lw $ra, ($sp)
addi $sp, $sp, 20
jr $ra

exit_program:
