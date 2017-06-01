; ------- TABELA DE CORES -------
; adicione ao caracter para Selecionar a cor correspondente

; 0 branco							0000 0000
; 256 marrom						0001 0000
; 512 verde							0010 0000
; 768 oliva							0011 0000
; 1024 azul marinho					0100 0000
; 1280 roxo							0101 0000
; 1537 teal							0110 0000
; 1793 prata						0111 0000
; 2048 cinza						1000 0000
; 2304 vermelho						1001 0000
; 2561 lima							1010 0000
; 2816 amarelo						1011 0000
; 3072 azul							1100 0000
; 3328 rosa							1101 0000
; 3584 aqua							1110 0000
; 3839 branco						1111 0000

jmp main

Letra: var #1
Palavra: var #30
PalavraSize: var #1
TryList: var #60
TryListSize: var #1
Acerto: var #1
Erro: var #1

m1: string "Digite uma palavra: "
m2: string "Digite uma letra: "
m3: string "                "
m4: string "YOU WIN!"
m5: string "Quer jogar novamente? (s/n) "
m7: string "Letra repetida. Letras: "
m8: string "               "

; ------ Programa Principal -----------

main:
	loadn r0, #0
	store Letra, r0
	store Palavra, r0
	store PalavraSize, r0
	store TryList, r0
	store TryListSize, r0
	store Acerto, r0
	store Erro, r0
	call DesenhaMenu
	call LimpaTela
	call DesenhaForca
	
	loadn r0, #1040
	loadn r1, #m1
	call Imprime
	
	loadn r5, #1060			;posição na tela
	loadn r6, #Palavra		;endereço onde vai armazenar
	call InserePalavra
	
	call DesenhaLinhas
	
	loadn r0, #1040
	call LimpaLinha
	loadn r1, #m2
	call Imprime
	
	LoopMain:
		loadn r5, #1058
		loadn r6, #Letra
		call InsereLetra		
		call Compara
		call TestaFim
		jmp LoopMain
		
	halt
	
;************************************************************************
;						IMPRIME
;************************************************************************
	
Imprime:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem;   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r2 na pilha para ser usado na subrotina
	push r3	; protege o r3 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

LoopImprime:	
	loadi r2, r1	; r2 <- Conteudo da MEMORIA enderecada por r1
	cmp r2, r3	; Checa se chegou no final da mensagem = "\0"
	jeq SaiImprime	; Se chegou no fin da mensagem
	outchar r2, r0	; Imprima caracter
	inc r0		; incrementa posicao na tela
	inc r1		; incrementa ponteiro da mensagem
	jmp LoopImprime	; Goto Loop
	
SaiImprime:	
	pop r3	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r2
	pop r1
	pop r0
	rts
	
;************************************************************************
;						LIMPA TELA
;************************************************************************

LimpaTela:
	push r0
	push r1
	push r2
	push r3
	
	linhaEmBranco : string "                                        "
	loadn r0, #0
	loadn r1, #linhaEmBranco
	
	call Imprime
	
	loadn r2, #40
	loadn r3, #1160
	
LoopLimpaTela:
	add r0, r0, r2
	call Imprime
	cmp r0, r3
	jeq SaiLimpaTela
	jmp LoopLimpaTela
	
SaiLimpaTela:
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;************************************************************************
;						LIMPA LINHA
;************************************************************************
LimpaLinha:
	push r0
	push r1
	linhaemBranco2: string "                                        "
	loadn r1, #linhaemBranco2
	call Imprime
	pop r1
	pop r0
	rts
	
;************************************************************************
;						DESENHA MENU
;************************************************************************
DesenhaMenu:
	push r0
	push r1
	push r2
	push r3
	push r4
	l01 : string "                                        "
	l02 : string "                                        "
	l03 : string "                                        "
	l04 : string "                                        "
	l05 : string "                                        "
	l06 : string "                                        "
	l07 : string "            JOGO     DA                 "
	l08 : string "                                        "
	l09 : string "  ||==== ||===|| ||===|| ||=== ||===||  "
	l10 : string "  ||     ||   || ||   || ||    ||   ||  "
	l11 : string "  ||     ||   || ||   || ||    ||   ||  "
	l12 : string "  ||===  ||   || ||===   ||    ||===||  "
	l13 : string "  ||     ||   || ||   || ||    ||   ||  "
	l14 : string "  ||     ||   || ||   || ||    ||   ||  "
	l15 : string "  ||     ||===|| ||   || ||=== ||   ||  "
	l16 : string "                                        "
	l17 : string "                                        "
	l18 : string "                                        "
	l19 : string " PRESSIONE QUALQUER TECLA PARA COMECAR  "
	l20 : string "                                        "
	l21 : string "                                        "
	l22 : string "                                        "
	l23 : string "                                        "
	l24 : string "                                        "
	l25 : string "                                        "
	l26 : string "                                        "
	l27 : string "                                        "
	l28 : string "                                        "
	l29 : string "                                        "
	l30 : string "                                        "
	
	loadn r0, #0
	loadn r2, #40
	
	loadn r1, #l01
	call Imprime
	add r0, r0, r2
	loadn r1, #l02
	call Imprime
	add r0, r0, r2
	loadn r1, #l03
	call Imprime
	add r0, r0, r2
	loadn r1, #l04
	call Imprime
	add r0, r0, r2
	loadn r1, #l05
	call Imprime
	add r0, r0, r2
	loadn r1, #l06
	call Imprime
	add r0, r0, r2
	loadn r1, #l07
	call Imprime
	add r0, r0, r2
	loadn r1, #l08
	call Imprime
	add r0, r0, r2
	loadn r1, #l09
	call Imprime
	add r0, r0, r2
	loadn r1, #l10
	call Imprime
	add r0, r0, r2
	loadn r1, #l11
	call Imprime
	add r0, r0, r2
	loadn r1, #l12
	call Imprime
	add r0, r0, r2
	loadn r1, #l13
	call Imprime
	add r0, r0, r2
	loadn r1, #l14
	call Imprime
	add r0, r0, r2
	loadn r1, #l15
	call Imprime
	add r0, r0, r2
	loadn r1, #l16
	call Imprime
	add r0, r0, r2
	loadn r1, #l17
	call Imprime
	add r0, r0, r2
	loadn r1, #l18
	call Imprime
	add r0, r0, r2
	loadn r1, #l19
	call Imprime
	add r0, r0, r2
	loadn r1, #l20
	call Imprime
	add r0, r0, r2
	loadn r1, #l21
	call Imprime
	add r0, r0, r2
	loadn r1, #l22
	call Imprime
	add r0, r0, r2
	loadn r1, #l23
	call Imprime
	add r0, r0, r2
	loadn r1, #l24
	call Imprime
	add r0, r0, r2
	loadn r1, #l25
	call Imprime
	add r0, r0, r2
	loadn r1, #l26
	call Imprime
	add r0, r0, r2
	loadn r1, #l27
	call Imprime
	add r0, r0, r2
	loadn r1, #l28
	call Imprime
	add r0, r0, r2
	loadn r1, #l29
	call Imprime
	add r0, r0, r2
	loadn r1, #l30
	call Imprime
	add r0, r0, r2
	
	loadn r3, #255
	LoopEnter:
		inchar r4				;le do teclado
		cmp r4, r3				;compara com 255
		jeq LoopEnter
		
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;************************************************************************
;						DESENHA FORCA
;************************************************************************

DesenhaForca:
	push r0
	push r1
	push r2
	
	linha31 : string "    |         (D_D)                     "
	linha32 : string "    |          /|\\                      "
	linha33 : string "    |         | | |                    "
	linha34 : string "    |           |                       "
	linha35 : string "    |          / \\                      "
	linha36 : string "    |          | |                      "
	linha37 : string "    |          / \\                      "
	
	
	linha01 : string "                                        "
	linha02 : string "     ___________                        "
	linha03 : string "    |           |                       "
	linha04 : string "    |           |                       "
	linha05 : string "    |           |                       "
	linha06 : string "    |           |                       "
	linha07 : string "    |                                   "
	linha08 : string "    |                                    "
	linha09 : string "    |                                  "
	linha10 : string "    |                                   "
	linha11 : string "    |                                    "
	linha12 : string "    |                                   "
	linha13 : string "    |                                    "
	linha14 : string "    |========________=========          "
	linha15 : string "    |                                   "
	linha16 : string "    |                                   "
	linha17 : string "    |                                   "
	linha18 : string "    |                                   "
	linha19 : string "    |//////////////////////////         "
	linha20 : string "                                        "
	linha21 : string "                                        "
	linha22 : string "                                        "
	linha23 : string "                                        "
	linha24 : string "                                        "
	linha25 : string "                                        "
	linha26 : string "                                        "
	linha27 : string "                                        "
	linha28 : string "                                        "
	linha29 : string "                                        "
	linha30 : string "                                        "
	
	loadn r0, #0
	loadn r2, #40
	
	loadn r1, #linha01
	call Imprime
	add r0, r0, r2
	loadn r1, #linha02
	call Imprime
	add r0, r0, r2
	loadn r1, #linha03
	call Imprime
	add r0, r0, r2
	loadn r1, #linha04
	call Imprime
	add r0, r0, r2
	loadn r1, #linha05
	call Imprime
	add r0, r0, r2
	loadn r1, #linha06
	call Imprime
	add r0, r0, r2
	loadn r1, #linha07
	call Imprime
	add r0, r0, r2
	loadn r1, #linha08
	call Imprime
	add r0, r0, r2
	loadn r1, #linha09
	call Imprime
	add r0, r0, r2
	loadn r1, #linha10
	call Imprime
	add r0, r0, r2
	loadn r1, #linha11
	call Imprime
	add r0, r0, r2
	loadn r1, #linha12
	call Imprime
	add r0, r0, r2
	loadn r1, #linha13
	call Imprime
	add r0, r0, r2
	loadn r1, #linha14
	call Imprime
	add r0, r0, r2
	loadn r1, #linha15
	call Imprime
	add r0, r0, r2
	loadn r1, #linha16
	call Imprime
	add r0, r0, r2
	loadn r1, #linha17
	call Imprime
	add r0, r0, r2
	loadn r1, #linha18
	call Imprime
	add r0, r0, r2
	loadn r1, #linha19
	call Imprime
	add r0, r0, r2
	loadn r1, #linha20
	call Imprime
	add r0, r0, r2
	loadn r1, #linha21
	call Imprime
	add r0, r0, r2
	loadn r1, #linha22
	call Imprime
	add r0, r0, r2
	loadn r1, #linha23
	call Imprime
	add r0, r0, r2
	loadn r1, #linha24
	call Imprime
	add r0, r0, r2
	loadn r1, #linha25
	call Imprime
	add r0, r0, r2
	loadn r1, #linha26
	call Imprime
	add r0, r0, r2
	loadn r1, #linha27
	call Imprime
	add r0, r0, r2
	loadn r1, #linha28
	call Imprime
	add r0, r0, r2
	loadn r1, #linha29
	call Imprime
	add r0, r0, r2
	loadn r1, #linha30
	call Imprime
	add r0, r0, r2
	
	pop r2
	pop r1
	pop r0
	rts
	
DesenhaEnforcado:
	push r0
	push r1
	push r2
	
	linha41 : string "                                        "
	linha42 : string "     ___________                        "
	linha43 : string "    |           |                       "
	linha44 : string "    |           |                       "
	linha45 : string "    |           |        MAY GOD        "
	linha46 : string "    |           |        HAVE           "
	linha47 : string "    |           |        MERCY          "
	linha48 : string "    |           |        ON YOUR        "
	linha49 : string "    |           |        SOUL           "
	linha50 : string "    |       _ (X_X) _                   "
	linha51 : string "    |        \\_/|\\_/                   "
	linha52 : string "    |           |                       "
	linha53 : string "    |           |                       "
	linha54 : string "    |========  / \\   =========          "
	linha55 : string "    |          | |                      "
	linha56 : string "    |          / \\                      "
	linha57 : string "    |                                   "
	linha58 : string "    |                                   "
	linha59 : string "    |///////////////////////////////////"
	linha60 : string "                                        "
	linha61 : string "       Palavra:                         "
	linha62 : string "                                        "
	linha63 : string "                                        "
	linha64 : string "                                        "
	linha65 : string "                                        "
	linha66 : string "                                        "
	linha67 : string "                                        "
	linha68 : string "                                        "
	linha69 : string "                                        "
	linha70 : string "                                        "
	
	loadn r0, #0
	loadn r2, #40
	
	loadn r1, #linha41
	call Imprime
	add r0, r0, r2
	loadn r1, #linha42
	call Imprime
	add r0, r0, r2
	loadn r1, #linha43
	call Imprime
	add r0, r0, r2
	loadn r1, #linha44
	call Imprime
	add r0, r0, r2
	loadn r1, #linha45
	call Imprime
	add r0, r0, r2
	loadn r1, #linha46
	call Imprime
	add r0, r0, r2
	loadn r1, #linha47
	call Imprime
	add r0, r0, r2
	loadn r1, #linha48
	call Imprime
	add r0, r0, r2
	loadn r1, #linha49
	call Imprime
	add r0, r0, r2
	loadn r1, #linha50
	call Imprime
	add r0, r0, r2
	loadn r1, #linha51
	call Imprime
	add r0, r0, r2
	loadn r1, #linha52
	call Imprime
	add r0, r0, r2
	loadn r1, #linha53
	call Imprime
	add r0, r0, r2
	loadn r1, #linha54
	call Imprime
	add r0, r0, r2
	loadn r1, #linha55
	call Imprime
	add r0, r0, r2
	loadn r1, #linha56
	call Imprime
	add r0, r0, r2
	loadn r1, #linha57
	call Imprime
	add r0, r0, r2
	loadn r1, #linha58
	call Imprime
	add r0, r0, r2
	loadn r1, #linha59
	call Imprime
	add r0, r0, r2
	loadn r1, #linha60
	call Imprime
	add r0, r0, r2
	loadn r1, #linha61
	call Imprime
	add r0, r0, r2
	loadn r1, #linha62
	call Imprime
	add r0, r0, r2
	loadn r1, #linha63
	call Imprime
	add r0, r0, r2
	loadn r1, #linha64
	call Imprime
	add r0, r0, r2
	loadn r1, #linha65
	call Imprime
	add r0, r0, r2
	loadn r1, #linha66
	call Imprime
	add r0, r0, r2
	loadn r1, #linha67
	call Imprime
	add r0, r0, r2
	loadn r1, #linha68
	call Imprime
	add r0, r0, r2
	loadn r1, #linha69
	call Imprime
	add r0, r0, r2
	loadn r1, #linha70
	call Imprime
	add r0, r0, r2
	
	pop r2
	pop r1
	pop r0
	rts

;********************************************************
;			DESENHA LINHAS DA PALAVRA DA FORCA
;********************************************************
DesenhaLinhas:
	push r0
	push r1
	push r2
	push r3
	push r4
	linha : string "_" 
	loadn r0, #967
	loadn r2, #0
	load r3, PalavraSize
	LoopLinha:
		cmp r2, r3
		jeq SaiDesenhaLinhas
		loadn r1, #linha
		call Imprime
		inc r0
		inc r2
		jmp LoopLinha
SaiDesenhaLinhas:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;************************************************************
;					DIGITA LETRA
;************************************************************
DigitaLetra:

	push r1

	loadn r1, #255				;condicao de parada da espera ocupada
	
	LoopDigitaLetra:
		inchar r0				;le do teclado
		cmp r0, r1				;compara com 255
		jeq LoopDigitaLetra

		
	pop r1
	
	rts
	
;************************************************************************
;						INSERE PALAVRA
;************************************************************************
InserePalavra:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r5
	push r6
	loadn r2, #13				;condicao de parada p/ ler a string
	loadn r3, #0
 InsereTecla:
	call DigitaLetra
	outchar r0, r5				;escreve na tela o caracter digitado
	cmp r0, r2
	jeq SaiInserePalavra
	storei r6, r0	;armazena na posicao apontada por r6 o conteudo de r0
	inc r3			;incrementa PalavraSize
	store PalavraSize, r3
	inc r5			;incremento da tela
	inc r6			; incremento para string
	jmp InsereTecla

SaiInserePalavra:
	loadn r0, #'\0'
	storei r6, r0
	pop r6
	pop r5
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
; InserePalavra:	  
	; push fr ; protege o registrador de flags
	; push r0	; contador
	; push r1	; enter
	; push r2	; contador de letras para o vetor que armazena a palavra
	; push r3	; ponteiro para palavra
	; push r4 ; palavra[r3+r2]
	; push r5
	; loadn r1, #13	; Codigo enter
	; loadn r2, #0
	; loadn r3, #Palavra
	; loadn r5, #40

		;call printDigPalavra
		
		; Loop:
			; call DigitaLetra
			; load r0, Letra
			; cmp r0,r1 ;comparacao se r0 eh enter
			; jeq inputPalavra_Fim
			
			; add r4,r3,r2
			; storei r4,r0
			; inc r2
			; store PalavraSize, r2
			; cmp r2,r5
			; jne Loop
	
	; inputPalavra_Fim:
		; loadn r0,#0
		; add r4,r3,r2
		; storei r4,r0
		; pop r5
		; pop r4
		; pop r3
		; pop r2
		; pop r1
		; pop r0
		; pop fr
		; rts	
	
	
;***************************************************************;
;						INSERE LETRA 									
;***************************************************************;	
InsereLetra:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	loadn r2, #13				;condicao de parada p/ ler a string
	loadn r3, #0
	load r4, TryListSize
	loadn r7, #TryList

	LoopInsereLetra:	
		call DigitaLetra
		outchar r0, r5				;escreve na tela o caracter digitado
		
		cmp r0, r2
		jeq LoopInsereLetra
		
		cmp r4, r3					; TryListSize = 0?
		jeq SaiInsereLetra			; se sim, armazena na TryList
		Loop:
			cmp r6, r3
			jeq SaiInsereLetra

			loadi r6, r7
			cmp r0, r6			; compara 
			jeq Achou
			
			inc r7
			jmp Loop
		
Achou: 
	loadn r0, #1120
	loadn r1, #m7
	call Imprime
	
	loadn r0, #1144
	loadn r1, #TryList
	call Imprime
	
	jmp LoopInsereLetra
	
SaiInsereLetra:
	loadn r7, #TryList
	add r7, r7, r4
	storei r7, r0
	loadi r6, r7
	store Letra, r6
	inc r4
	store TryListSize, r4
	loadn r0, #'\0'
	inc r7
	storei r7, r0
	
Saidevez:
	loadn r0, #1120
	call LimpaLinha
	loadn r0, #1160
	call LimpaLinha

	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
;***************************************************************;
;						COMPARA									
;***************************************************************;
Compara:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	loadn r0, #0    ;n de erros
	loadn r1, #0    ; contador
	loadn r2, #0    ; FlagAcerto
	load r3, Letra
	loadn r4, #Palavra
	load r5, PalavraSize
	loadn r7, #0

	LoopCompara:
		cmp r1, r5
		jeq LetraErro
		
		loadi r6, r4
		cmp r3, r6
		jeq LetraAcerto
		
		Continua_LoopCompara:
		inc r4
		inc r1
		
		jmp LoopCompara
LetraAcerto:
	loadn r0, #967
	add r0, r0, r1

	outchar r3, r0
	inc r0
	load r0, Acerto
	loadn r2, #1
	add r0, r0, r2
	store Acerto, r0
	jmp Continua_LoopCompara
LetraErro:
	cmp r7, r2
	jne Compara_Fim 
	inc r0
	load r6, Erro
	add r6, r6, r0
	store Erro, r6
	;halt
	Compara_Case1:
	loadn r0, #1
	cmp r6,r0 ; se erro = 1
	jne Compara_Case2
	loadn r0, #240
	loadn r1, #linha31 ; Desenha a cabeca
	call Imprime
	jmp Compara_Fim
	
	Compara_Case2:
	loadn r0, #2 ;se erro = 2
	cmp r6, r0
	jne Compara_Case3
	loadn r0, #296
	loadn r1, #'|' ; Desenha o corpo
	outchar r1, r0
	loadn r0, #336
	outchar r1, r0
	loadn r0, #376
	outchar r1, r0
	jmp Compara_Fim	
	
	Compara_Case3:
	loadn r0, #3 ;se erro = 3
	cmp r6, r0
	jne Compara_Case4
	loadn r1, #'/' ; desenha braco esquerdo
	loadn r2, #295
	outchar r1, r2
	loadn r1, #'|'
	loadn r2, #334
	outchar r1, r2
	jmp Compara_Fim
	
	Compara_Case4:
	loadn r0, #4 ;se erro = 4
	cmp r6, r0
	jne Compara_Case5
	loadn r1, #'\\' ; desenha braco direito
	loadn r2, #297
	outchar r1, r2
	loadn r1, #'|'
	loadn r2, #338
	outchar r1, r2
	jmp Compara_Fim
	
	Compara_Case5:
	loadn r0, #5 ;se erro = 5
	cmp r6, r0
	jne Compara_Case6
	loadn r1, #'/' ; desenha perna esquerda
	loadn r2, #415
	outchar r1, r2
	loadn r1, #'|'
	loadn r2, #455
	outchar r1, r2
	loadn r1, #'/'
	loadn r2, #495
	outchar r1, r2
	jmp Compara_Fim
	
	Compara_Case6:
	loadn r1, #'\\' ; desenha perna direita
	loadn r2, #417
	outchar r1, r2
	loadn r1, #'|'
	loadn r2, #457
	outchar r1, r2
	loadn r1, #'\\'
	loadn r2, #497
	outchar r1, r2
	jmp Compara_Fim
	
	Compara_Fim:
		pop r7
		pop r6
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		pop fr
		rts
	
	
;***************************************************************;
;						TESTA FIM									
;***************************************************************;
TestaFim:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r0, #7
	load r1, Erro
	cmp r1, r0
	jeq VocePerdeu
	
	load r1, Acerto
	load r2, PalavraSize
	cmp r1, r2
	jeq VoceVenceu
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts 
	
VoceVenceu:
	loadn r0, #422
	loadn r1, #m4
	call Imprime
	
	mens : string "Palavra: "
	loadn r0, #807
	loadn r1, #mens
	call Imprime
	loadn r0, #940
	call LimpaLinha
	loadn r0, #816
	loadn r1, #Palavra
	call Imprime
	loadn r0, #886
	loadn r1, #m5
	call Imprime
	
	call DigitaLetra
	loadn r1, #'s'
	cmp r0, r1
	jeq comeca_jogo_novamente
	call LimpaTela
	halt 
	
VocePerdeu:
	call DesenhaEnforcado
	loadn r0, #816
	loadn r1, #Palavra
	call Imprime
	loadn r0, #886
	loadn r1, #m5
	call Imprime
	
	call DigitaLetra
	loadn r1, #'s'
	cmp r0, r1
	jeq comeca_jogo_novamente
	call LimpaTela
	halt 
	
comeca_jogo_novamente:
	call LimpaTela
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	jmp main