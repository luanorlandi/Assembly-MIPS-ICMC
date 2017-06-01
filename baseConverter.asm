# Trabalho de Organizacao de computadores
#
# Luan Orlandi         8531532
# Henrique Pasquini    8532252

.data
#strings para auxliar o usuario
stringNumberBaseInput:  .asciiz "\nDigite a base de entrada do numero: "
stringNumberInput: 	.asciiz "\nDigite o numero: "
stringNumberBaseOutput: .asciiz "\nDigite a base de saida do numero: "
stringIncorrectBase:	.asciiz "\nBase nao reconhecida, use B, O, D ou H."
stringNumberConverted:	.asciiz "\nO numero convertido eh: "
stringNumberInvalid:	.asciiz "\nNumero invalido ou nao pode ser representado nessa base."
stringNumberOverflow:	.asciiz "\nO numero ultrapassa 32 bits sem sinal, resultado sofrera overflow..."

#dados de entrada
baseInput:		.word 10
baseOutput:		.word 10
numberInStringInput:	.space 36		#string com o numero, o binario eh o maior possivel, sendo ate 32 caracteres + '\0'
numberInStringInputQty: .word 0			#contem a quantidade de caracteres armazenados em "numberInStringInput"

#resultados
numberInDecimal: 	.word 0 		#numero em 32bits em decimal sem sinal, menor = 0 e maior = 4294967295
numberInStringOutput:	.space 36		#contem o numero numa string na base convertida
numberInStringOutputQty:.word 0			#contem a quantidade de caracteres armazenados em "numberInStringOutput"

#auxiliar de conversao
numberInStringInverted:	.space 36		#auxiliar que armazena um numero (pode ser de input ou output) invertido numa string

.text

main:
	jal readBaseInput			#le a base do numero que sera fornecido como entrada
	jal readNumberInString			#le o numero que sera convertido
	jal baseToDecimal			#converte o numero para a base decimal
	jal readBaseOutput			#le a base para qual o numero deve ser convertido
	jal decimalToBase			#converte o decimal para a base de saida
	jal printResult				#mostra o numero convertido

	li $v0, 10				# termina o programa
	syscall

###########################################################################
#	 		READ BASE INPUT
###########################################################################
#le um caractere que determina a base no numero a ser digitado
#esse caractere eh convertido para um numero inteiro e armazenado
#em baseInput
readBaseInput:
	addi $sp, $sp, -4			#decrementa pilha
	sw $ra, 0($sp)				#push $ra
	
	li $v0, 4				#printa string
	la $a0, stringNumberBaseInput		#texto para digitar a base inicial
	syscall
	
	li $v0, 12				#le um char, retorna o char em $v0
	syscall
	
	move $a0, $v0
	jal readBase
	
	bne $v0, $zero, exitReadBaseInput
	li $v0, 4				#printa string
	la $a0, stringIncorrectBase		#texto dizendo que a base n foi reconhecida
	syscall
	j readBaseInput
	
	exitReadBaseInput:
		sw $v0, baseInput		#armazena o numero da base
	
		lw $ra, 0($sp)			#pop $ra
		addi $sp, $sp, 4		#incrementa pilha
	
		jr $ra

###########################################################################
#	 		READ BASE OUTPUT
###########################################################################
#le um caractere que determina a base em que o numero sera convertido
#esse caractere eh convertido para um numero inteiro e armazenado
#em baseOutput
readBaseOutput:
	addi $sp, $sp, -4			#decrementa pilha
	sw $ra, 0($sp)				#push $ra
	
	li $v0, 4				#printa string
	la $a0, stringNumberBaseOutput		#texto para digitar a base de saida
	syscall
	
	li $v0, 12				#le um char, retorna o char em $v0
	syscall
	
	move $a0, $v0
	jal readBase
	
	bne $v0, $zero, exitReadBaseOutput
	li $v0, 4				#printa string
	la $a0, stringIncorrectBase		#texto dizendo que a base n foi reconhecida
	syscall
	j readBaseOutput
	
	exitReadBaseOutput:
		sw $v0, baseOutput		#armazena o numero da base
	
		lw $ra, 0($sp)			#pop $ra
		addi $sp, $sp, 4		#incrementa pilha
	
	jr $ra
	

###########################################################################
#			READ BASE
###########################################################################
#le o caractere e retorna o numero correspondente da base
#(ex: D corresponde a 10)
#Argumentos: $a0 caractere
#Retorno: $v0 numero da base
readBase:
	li $v0, 2				#verifica para binario (base 2)
	li $t1, 'B'
	beq $a0, $t1, exitReadBase
	li $t1, 'b'
	beq $a0, $t1, exitReadBase
	
	li $v0, 8				#verifica para octal (base 8)
	li $t1, 'O'
	beq $a0, $t1, exitReadBase
	li $t1, 'o'
	beq $a0, $t1, exitReadBase
	
	li $v0, 10				#verifica para decimal (base 10)
	li $t1, 'D'
	beq $a0, $t1, exitReadBase
	li $t1, 'd'
	beq $a0, $t1, exitReadBase
	
	li $v0, 16				#verifica para hexadecimal (base 16)
	li $t1, 'H'
	beq $a0, $t1, exitReadBase
	li $t1, 'h'
	beq $a0, $t1, exitReadBase
	
	li $v0, 0				#nao eh nenhuma base especificada, usa flag 0
	
	exitReadBase:
		jr $ra

###########################################################################
#	 		READ NUMBER IN STRING
###########################################################################
#le uma string que sera o numero de entrada
#essa string eh armazenada em numberInStringInput
readNumberInString:
	addi $sp, $sp, -4			#decrementa pilha
	sw $ra, 0($sp)				#push $ra
	
	li $v0, 4				#printa string
	la $a0, stringNumberInput		#texto para digitar o numero
	syscall
	
	li $v0, 8				#le uma string
	la $a0, numberInStringInput		#argumento para o endereco da string
	li $a1, 33				#argumento para o tamanho max da string
	syscall					#se chegar no limite 33 do buffer, para a leitura, n exigindo o ENTER e  n colocando \n
	
	#verifica se o numero pode ser representado na base indicada
	la $a0, numberInStringInput
	lw $a1, baseInput
	jal checkValidNumber
	beq $v0, $zero, readNumberInString
	
	#le qtns caracteres foram digitados
	la $s0, numberInStringInput
	li $s1, 0
	li $s3, 32
	
	loopReadNumberInString:
		addi $s1, $s1, 1				#incrementa o contador de qtd de caracteres
		addi $s0, $s0, 1				#incrementa o contador de leitura da string
		
		lb $s2, ($s0)					#carrega o caractere
		beq $s2, '\0', exitLoopReadNumberInString	#caso a string conter o numero maximo do buffer, n eh aplicado o '\n'
		bne $s2, '\n', loopReadNumberInString		#conta ate encontrar o final da string
	
	exitLoopReadNumberInString:
		sw $s1, numberInStringInputQty			#armazena a quantidade de caracteres lidos
	
		lw $ra, 0($sp)			#pop $ra
		addi $sp, $sp, 4		#incrementa pilha
		
		jr $ra

###########################################################################
#			REVERSE STRING
###########################################################################
#inverte uma string, armazenando o resultado em outra string
#Argumentos: a0 string, a1 tamanho, a2 string invertida
reverseString:
	lw, $t0, ($a1)				#carrega a string
	
	add $a2, $a2, $t0			#coloca a string invertida na posicao final
	subi $a2, $a2, 1
	
	loopReverseString:
		lb $t1, ($a0)			#le da string o caractere
		sb $t1, ($a2)			#armazena o caractere na string invertida
		addi $a0, $a0, 1		#avanca a string
		subi $a2, $a2, 1		#recua a string invertida
		
		subi $t0, $t0, 1		#decrementa o contador do tamanho
		
		bne $t0, $zero, loopReverseString
	
	jr $ra

###########################################################################
#			BASE TO DECIMAL
###########################################################################
#converte a string (numberInStringInput) da base (baseInput) para
#um numero em decimal e armazena em (numberInDecimal)
baseToDecimal:
	addi $sp, $sp, -4			#decrementa pilha
	sw $ra, 0($sp)				#push $ra
	
	la, $a0, numberInStringInput
	la, $a1, numberInStringInputQty
	la, $a2, numberInStringInverted
	jal reverseString			#inverte o numero para realizar o metodo
	
	lw $s0, baseInput			#base da potencia
	li $s1, 0				#expoente da potencia
	li $s2, 1				#resultado da potencia, 2 elevado a 0 por exemplo
	li $s3, 0				#numero em decimal final
	li $s6, 0				#flag para overflow
	
	la $s4, numberInStringInverted		#string que contem os numeros
	
	#verifica overflow para hexadecimal:
	li $t0, 16
	bne $s0, $t0, loopBaseToDecimal	#verfica se eh hexadecimal
	
	lw $t0, ($a1)			#carrega o tamanho da string
	li $t1, 8			#tamanho maximo possivel
	ble $t0, $t1, loopBaseToDecimal	#se maior q 8, entao o numero sofre overflow
	
	la $a0, stringNumberOverflow	#string avisando overflow no numero de entrada
	li $v0, 4			#printa string
	syscall
		
	li $s6, 1			#ativa flag overflow, para nao printar 2 vezes
	
	#loop de leitura do numero
	loopBaseToDecimal:
		lb $s5, ($s4)
		beq $s5, '\n', exitBaseToDecimal
		beq $s5, '\0', exitBaseToDecimal#caso a string tenha o tamanho maximo 33 atingido no buffer de leitura
		add $s4, $s4, 1			#incrementa o endereco de leitura da string
		
		move $a0, $s0
		move $a1, $s1
		jal pow				#calcula a potencia
		move $s2, $v0			#transfere o resultado para s2
		
		addi $s1, $s1, 1		#incrementa o expoente para o proximo
		
		move $a0, $s5
		jal getNumber			#pega o numero correspondente a aquele caractere
		move $s5, $v0
		
		mulu $s5, $s5, $s2		#base elevado ao expoente atual vezes o numero lido
		
		#verifica se houve overflow
		bne $s6, $zero, notOverflow	#ja foi detectado overflow, entao ignora a verificacao
		move $a0, $s3
		move $a1, $s5
		jal checkAddOverflow
		
		beq $v0, $zero, notOverflow
		
		#caso overflow, avisa
		la $a0, stringNumberOverflow	#string avisando overflow no numero de entrada
		li $v0, 4			#printa string
		syscall
		
		li $s6, 1			#ativa flag overflow, para nao printar 2 vezes
		
		notOverflow:
			addu $s3, $s3, $s5	#soma parcial para chegar no numero em decimal
			j loopBaseToDecimal
		
	exitBaseToDecimal:
		sw $s3, numberInDecimal		#armazena o numero
	
		lw $ra, 0($sp)			#pop $ra
		addi $sp, $sp, 4		#incrementa pilha
	
		jr $ra
	
###########################################################################
#	 		DECIMAL TO BASE
###########################################################################
#converte o numero de (numberInDecimal) de base (baseOutput) para
#a string (numberInStringOutput)
decimalToBase:
	addi $sp, $sp, -4			#decrementa pilha
	sw $ra, 0($sp)				#push $ra
	
	la $s4, numberInStringInverted		#vetor q contera os restos das divisoes pela base
	lw $s0, numberInDecimal			#carrega o numero decimal
	lw $s1, baseOutput			#carrega a base de conversao
	li $s3, 0				#contador para a quantidade caracteres armazenados
	
	loopDecimalToBase:
		divu $s0, $s1
		mflo $s0			#resultado de $s0/$s1
		mfhi $s2			#resultado de $s0 mod $s1
		
		move $a0, $s2
		jal getChar			#pega o caractere correspondente ao numero
		move $s2, $v0
		
		sb $s2, ($s4)			#armazena o resto
		addiu $s4, $s4, 1		#incrementa para armazenar na proxima posicao
		addi $s3, $s3, 1		#incrementa o contador
		
		bne $s0, $zero, loopDecimalToBase
     	
		la $s4, numberInStringOutputQty
		sw $s3, ($s4)
		
	#ate aqui tem o numero na base de conversao numa string mas invertido, devido ao metodo usado

	la, $a0, numberInStringInverted
	la, $a1, numberInStringOutputQty
	la, $a2, numberInStringOutput
	jal reverseString			#inverte a string para pegar o numero corretamente
	
	lw $ra, 0($sp)				#pop $ra
	addi $sp, $sp, 4			#incrementa pilha
	
	jr $ra

###########################################################################
#			PRINT RESULT
###########################################################################
#printa o numero convertido final para a base desejada
#(numberInStringOutput) deve conter o numero
printResult:
	la $a0, stringNumberConverted		#carrega o texto dizendo a conversao
	li $v0, 4				#printa string
	syscall
	
	la $a0, numberInStringOutput		#carrega o numero
	li $v0, 4				#printa string
	syscall
	
	jr $ra

###########################################################################
#				POW
###########################################################################
#realiza uma potencia
#Argumentos: a0 base, a1 expoente
#Resultado: v0 resultado da potencia
pow:
	li $v0, 1				#resultado da potencia
	
	loopPow:
		beq $a1, $zero, exitLoopPow
		
		mulu $v0, $v0, $a0
		
		subi $a1, $a1, 1		#decrementa o expoente
		
		j loopPow

	exitLoopPow:
		jr $ra
	
###########################################################################
#				GET CHAR
###########################################################################
#recebe um numero (de 0 a 15 em geral) e retorna o caractere dele na tabela ascii
#para maiores de 10, retorna A, B, C...
#Argumentos: a0 numero
#Resultado: v0 caractere
getChar:
	li $t0, 10
	blt $a0, $t0, getCharNumber		#caso seja um numero
	j getCharLetter				#caso seja uma letra
	
	getCharNumber:
		addi $v0, $a0, 48		#0 na tabela ascii
		j exitGetChar
	
	getCharLetter:
		addi $v0, $a0, 55		#10 + 55 = 65(A) na tabela ascii
		
	exitGetChar:
	jr $ra

###########################################################################
#				GET NUMBER
###########################################################################
#recebe um caractere (de 0 a 9 ou A a F em geral) e retorna o numero dele
#Argumentos: a0 caractere
#Resultado: v0 numero
getNumber:
	li $t0, 57
	ble  $a0, $t0, getNumberNumber		#caso seja um numero
	
	li $t0, 90
	ble  $a0, $t0, getNumberUpperLetter	#caso seja uma letra maiuscula
	j getNumberLesserLetter			#caso seja uma letra minuscula
	
	getNumberNumber:
		subi $v0, $a0, 48		#0 na tabela ascii
		j exitGetChar
	
	getNumberUpperLetter:
		subi $v0, $a0, 55		#x - 55 = [10, 15] na tabela ascii
		j exitGetNumber
	
	getNumberLesserLetter:
		subi $v0, $a0, 87		#x - 87 = [10, 15] na tabela ascii
		
	exitGetNumber:
	jr $ra
	
###########################################################################
#			CHECK VALID NUMBER
###########################################################################
#verifica se na string tem algum caractere estranho e
#se o numero corresponde a sua base
#Argumentos: a0 string, a1 base
#Resultado: v0 true ou false (1 ou 0), se eh valido
checkValidNumber:
	li $v0, 1				#inicia com true
	
	li $t0, 2
	beq $t0, $a1, checkValidNumberBinary
	li $t0, 8
	beq $t0, $a1, checkValidNumberOctal
	li $t0, 10
	beq $t0, $a1, checkValidNumberDecimal
	li $t0, 16
	beq $t0, $a1, checkValidNumberHexadecimal
	
	checkValidNumberBinary:			#checa se um numero eh binario
		li $t1, '0'
		li $t2, '1'
		j loopCheckValidNumber
		
	checkValidNumberOctal:			#checa se um numero eh octal
		li $t1, '0'
		li $t2, '7'
		j loopCheckValidNumber
		
	checkValidNumberDecimal:		#chega se um numero eh decimal
		li $t1, '0'
		li $t2, '9'
		j loopCheckValidNumber
		
	checkValidNumberHexadecimal:		#chega se um numero eh hexadecimal
		j loopCheckValidNumberHexadecimal
	
	loopCheckValidNumber:			#verifica se o numero nao esta entre os caracteres de t0 e t1
		lb $t0, ($a0)
		addi $a0, $a0, 1
		
		li $t3, '\n'
		beq $t0, $t3, validNumber
		li $t3, '\0'
		beq $t0, $t3, validNumber	#verifica se chegou no final da string
		
		blt $t0, $t1, invalidNumber	#caso nao corresponde aos caractes possiveis, invalida o numero
		bgt $t0, $t2, invalidNumber
		
		j loopCheckValidNumber
	
	loopCheckValidNumberHexadecimal:	
		lb $t0, ($a0)
		addi $a0, $a0, 1
		
		li $t3, '\n'
		beq $t0, $t3, validNumber
		li $t1, '\0'
		beq $t0, $t3, validNumber	#verifica se chegou no final da string
		
		li $t1, '0'
		blt $t0, $t1, invalidNumber	#caso nao corresponde aos caractes possiveis, invalida o numero
		
		li $t1, '9'
		ble $t0, $t1, loopCheckValidNumberHexadecimal
		
		li $t1, 'A'
		blt $t0, $t1, invalidNumber	#caso nao corresponde aos caractes possiveis, invalida o numero
		
		li $t1, 'F'
		ble $t0, $t1, loopCheckValidNumberHexadecimal
		
		li $t1, 'a'
		blt $t0, $t1, invalidNumber	#caso nao corresponde aos caractes possiveis, invalida o numero
		
		li $t1, 'f'
		bgt $t0, $t1, invalidNumber
		
		j loopCheckValidNumberHexadecimal
	
	invalidNumber:
		li $v0, 4			#printa string
		la $a0, stringNumberInvalid	#texto dizendo que o numero eh invalido
		syscall
		
		li $v0, 0			#retorna false
	
	validNumber:
		jr $ra

###########################################################################
#			CHECK ADD OVERFLOW
###########################################################################
#verfica se a soma de 2 numeros sem sinal em 32bits resulta em overflow
#Argumentos: $a0 e $a1 operandos
#Resultado: v0 true ou false (1 ou 0), se houve overflow
checkAddOverflow:
	li $v0, 0
	
	blt $a0, $zero, a0negative
	blt $a1, $zero, a1negative
	
	j exitCheckAddOverflow
	
	a0negative:
		blt $a1, $zero, a0a1negatives
		
		add $t0, $a0, $a1
		blt $t0, $zero, exitCheckAddOverflow
		li $v0, 1
		
		j exitCheckAddOverflow
		
	a1negative:
		add $t0, $a0, $a1
		blt $t0, $zero, exitCheckAddOverflow
		li $v0, 1
		
		j exitCheckAddOverflow
	
	a0a1negatives:
		li $v0, 1
		j exitCheckAddOverflow
	
	exitCheckAddOverflow:
		jr $ra