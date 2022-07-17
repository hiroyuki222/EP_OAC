.data
$n: .word 10
$k: .word 5

.text
.globl main
main:
	# A fun��o fatorial da forma que foi feita n�o estava retornando corretamente o valor de 1! e 0!
	# Posteriormente o problema foi resolvido usando um beq
	# Esse valor em $a0 � para um dos beq
	li $a0, 1

      	#fatorial de n
        li $a1, 1			# contador
        ld $s0, $n			# carregando o valor n da mem�ria
        addi $s3, $s0, -1		# esse valor de $s3 vai ser usado na condi��o de parada do loop
        la $a2, ($s0)			# n precisa ser passado como parametro, ent�o $a2 = n
        jal fatorial
        add $s4, $v0, $zero		# guardando resultado do fatorial de n em $s4
        
        # A prepera��o das vari�veis para chamar fatorial de k e depois n-k � basicamente o mesmo que foi feito acima
        #fatorial de k
        li $a1, 1
        ld $s0, $k
        addi $s3, $s0, -1
        la $a2, ($s0) 			# $a2 = k
        jal fatorial
        add $s5, $v0, $zero		# guardando resultado do fatorial de k em $s5
        
        #fatorial de n-k
        li $a1, 1
        ld $t0, $n
        ld $t1, $k
        sub $s0, $t0, $t1
        addi $s3, $s0, -1
        la $a2, ($s0) 			# $a2 = n-k
        jal fatorial 
        add $s6, $v0, $zero		# guardando resultado de n-k! em $s6
        
        #resultado
        mul $t0, $s5, $s6		# $t0 =  k! . (n-k)!
        div $t1, $s4, $t0 		# $t1 = n! / $t0
        
        add $a0, $t1, $zero
        li $v0,1                        # imprime o resultado
        syscall
        li $v0,10                        # termina
        syscall
          
fatorial:
	beq $a0, $a2, fatorial_1
	beq $zero, $a2, fatorial_1
	mul $t0, $a1, -1	# A depender da chamada, essa e as pr�ximas duas linhas funcionam como -- no valor de n, k ou (n-k)
	add $t1, $a2, $t0		# Mas o resultado do -- � guardado na tempor�ria $t1 
	mul $t0, $t0, -1
	mul $s0, $s0, $t1		# Nessa linha � que as multiplica��es do fatorial est�o sendo feitas
        addi $a1,$a1,1                	# incrementa o contador
        ble $a1,$s3,fatorial            # verifica se terminou e faz o loop
        add $v0, $s0, $zero		# resultado guardado na vari�vel de retorno
        jr $ra				# Quando o desvio jal � chamado, a instru��o interrompida fica guardada no $ra
        				# jr faz o retorno utilizando esse conte�do de $ra
 
fatorial_1:
	li $s0, 1
	add $v0, $s0, $zero
	jr $ra
        
        
