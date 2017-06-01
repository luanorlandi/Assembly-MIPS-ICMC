; Autores: Luan Orlandi
; e Henrique Pasquini 


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

m1: string "VOCE VENCEU!"
m2: string "VOCE PERDEU!"
m3: string "Jogar novamente? (y/n)"

posNaveAnt : var #1
posNave : var #1
posAlien : var #1
posAlienAnt : var #1
posTiro : var #1
posTiroAnt : var #1
posTiroAlien : var #1
posTiroAntAlien : var #1
IncRand : var #1	
Rand : var #30
	static Rand + #0, #3
	static Rand + #1, #0
	static Rand + #2, #4
	static Rand + #3, #1
	static Rand + #4, #6
	static Rand + #5, #2
	static Rand + #6, #5
	static Rand + #7, #5
	static Rand + #8, #4
	static Rand + #9, #6
	static Rand + #10, #0
	static Rand + #11, #3	
	static Rand + #12, #6
	static Rand + #13, #5
	static Rand + #14, #2
	static Rand + #15, #1
	static Rand + #16, #4
	static Rand + #17, #1	
	static Rand + #18, #5
	static Rand + #19, #3
	static Rand + #20, #2
	static Rand + #21, #6
	static Rand + #22, #6
	static Rand + #23, #4
	static Rand + #24, #5
	static Rand + #25, #3
	static Rand + #26, #1
	static Rand + #27, #0
	static Rand + #28, #2
	static Rand + #29, #4
	
Cenario : var #1200				; vetor com cada caractere do cenario
CenarioAtual: var #1			; guarda o numero, 1 ou 2, do cenario usado
static CenarioAtual, #1			; cenario que comeca
CenarioCor01 : var #1
CenarioCor02 : var #1
CenarioCor03 : var #1
static CenarioCor01, #3072		; cor azul
static CenarioCor02, #2304		; cor vermelha
static CenarioCor03, #3584		; cor aqua

;************************************************************************
;						CENARIO 01
;************************************************************************

Cenario01_linha01 : string " |                                      "
Cenario01_linha02 : string " |                          * ___    *  "
Cenario01_linha03 : string " |      *                    /   \\      "
Cenario01_linha04 : string " |*             *           /    _\\     "
Cenario01_linha05 : string " |                          |   /        "
Cenario01_linha06 : string " |           *              |   |        "
Cenario01_linha07 : string " |                *         |   \\__     "
Cenario01_linha08 : string " |                          \\     /     "
Cenario01_linha09 : string " |                           \\___/      "
Cenario01_linha10 : string " |  *                   *               "
Cenario01_linha11 : string " |                                   *  "
Cenario01_linha12 : string " |                        *             "
Cenario01_linha13 : string " |      *                               "
Cenario01_linha14 : string " |               _l                     "
Cenario01_linha15 : string " |         ___  _ll_                    "
Cenario01_linha16 : string " |        |x x|    Tl_                  "
Cenario01_linha17 : string " |        | > |      Tl_          *     "
Cenario01_linha18 : string " |        \\|||/  _____T/                "
Cenario01_linha19 : string " |       ___llTTTT                      "
Cenario01_linha20 : string " |      lT__ | __                       "
Cenario01_linha21 : string " |      l ___| ___                      "
Cenario01_linha22 : string " |   _ l   __ | __                      "
Cenario01_linha23 : string " |   \\|/     _|_                        "
Cenario01_linha24 : string " |          _/ \\_                       "
Cenario01_linha25 : string " |          ||||||                      "
Cenario01_linha26 : string " |         ||/   \\|                    "
Cenario01_linha27 : string " |         |/     \\|                    "
Cenario01_linha28 : string " |         |       |                    "
Cenario01_linha29 : string " |        ||        |                   "
Cenario01_linha30 : string " |        |         ||                  "

;************************************************************************
;						CENARIO 02
;************************************************************************

Cenario02_linha01 : string " |//////////////////////////////////////"
Cenario02_linha02 : string " |//////////////////////////////////////"
Cenario02_linha03 : string " |//////////////////////////////////////"
Cenario02_linha04 : string " |======================================"
Cenario02_linha05 : string " |                                      "
Cenario02_linha06 : string " |                                      "
Cenario02_linha07 : string " |                ___                   "
Cenario02_linha08 : string " |               /   \\                  "
Cenario02_linha09 : string " |              /     \\                 "
Cenario02_linha10 : string " |              |     |                 "
Cenario02_linha11 : string " |              |     |                 "
Cenario02_linha12 : string " |              |     |                 "
Cenario02_linha13 : string " |              \\     /                 "
Cenario02_linha14 : string " |               \\___/                  "
Cenario02_linha15 : string " |                                      "
Cenario02_linha16 : string " |                                      "
Cenario02_linha17 : string " |                                      "
Cenario02_linha18 : string " |                                      "
Cenario02_linha19 : string " |                                      "
Cenario02_linha20 : string " |    (D_D)               _ (U_U) _     "
Cenario02_linha21 : string " |     /|\\                 \\_/|\\_/      "
Cenario02_linha22 : string " |    | | |                   |         "
Cenario02_linha23 : string " |      |                     |         "
Cenario02_linha24 : string " |     / \\                   / \\        "
Cenario02_linha25 : string " |     | |                   | |        "
Cenario02_linha26 : string " |     / \\                   / \\        "
Cenario02_linha27 : string " |======================================"
Cenario02_linha28 : string " |//////////////////////////////////////"
Cenario02_linha29 : string " |//////////////////////////////////////"
Cenario02_linha30 : string " |//////////////////////////////////////"

;************************************************************************
;						CENARIO 03
;************************************************************************

Cenario03_linha01 : string " |        ___                     *     "
Cenario03_linha02 : string " | *    */   \\        *                 "
Cenario03_linha03 : string " |  *   /    _\\     *                   "
Cenario03_linha04 : string " |      |   /                           "
Cenario03_linha05 : string " |   *  |   |                  *        "
Cenario03_linha06 : string " |      |   \\__                   *    "
Cenario03_linha07 : string " |      \\     /              *          "
Cenario03_linha08 : string " |       \\___/      +---+               "
Cenario03_linha09 : string " |                  |   |               "
Cenario03_linha10 : string " |              *   |   |          +---+"
Cenario03_linha11 : string " |     +---+        |   |          |   |"
Cenario03_linha12 : string " |     |   |  +---+ |   |          |   |"
Cenario03_linha13 : string " |  *  |   |  |   | |   |          |   |"
Cenario03_linha14 : string " |     |   |  |   | |   |    *     |   |"
Cenario03_linha15 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha16 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha17 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha18 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha19 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha20 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha21 : string " |     |   |  |   | |   |          |   |"
Cenario03_linha22 : string " |     |   |  |   | |   |  +----+  |   |"
Cenario03_linha23 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha24 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha25 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha26 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha27 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha28 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha29 : string " |     |   |  |   | |   |  |    |  |   |"
Cenario03_linha30 : string " |======================================"

;************************************************************************
;						MAIN
;************************************************************************

main:
	loadn r0, #0	;variavel global da pos do tiro
	store posTiro, r0
	loadn r0, #920   ;variavel global da pos da nave
	store posNave, r0
	loadn r0, #835
	store posAlien, r0	;variavel global da pos do alien
	
	loadn r0, #834
	store posTiroAlien, r0		; pos inicial do tiro do alien
	
	loadn r1, #'X' ; nave
	loadn r2, #' ' ; espaco para apagar nave
	call DesenhaNave
	loadn r1, #'A' ; alien
	call DesenhaAlien
	loadn r1, #'-' ; tiro
	call DesenhaTiro
	
	
	loadn r1, #'=' ; tiro do alien
	call DesenhaTiroAlien
	
	loadn r3, #0
	loadn r4, #0
	loadn r5, #999
	
	call DesenhaMenu
	
	call CarregaCenario
	call DesenhaCenario
	
	Loop:
		loadn r1, #'X'
		loadn r2, #10
		mod r2, r3, r2
		cmp r2, r4
		jne GoToAlien
		call ApagaNave
		call RecalculaPos 
		call DesenhaNave
		GoToAlien:
		loadn r2, #10
		mod r2, r3, r2
		cmp r2, r4
		jne GoToTiro
		loadn r1, #'A'
		call ApagaAlien
		call RecalculaPosAlien
		call DesenhaAlien
		GoToTiro:
		loadn r2, #2
		mod r2, r3, r2
		cmp r2, r4
		jne GoToTiroAlien
		loadn r1, #'-'
		call ApagaTiro
		call RecalculaPosTiro
		call DesenhaTiro
		
		GoToTiroAlien:
		loadn r2, #2
		mod r2, r3, r2
		cmp r2, r4
		jne GoToLoop
		loadn r1, #'='
		call ApagaTiroAlien
		call RecalculaPosTiroAlien
		call DesenhaTiroAlien
		
		GoToLoop:
		inc r3
		cmp r3, r5
		jeq reseta_cont
		go_back:
		call Delay
		
		call TestaFim
		
		jmp Loop
	
	halt
	
reseta_cont:
	loadn r3, #0
	jmp go_back
	
DesenhaNave:
	load r0, posNave
	outchar r1, r0
	store posNaveAnt, r0
	rts
	
ApagaNave:
	load r0, posNaveAnt
	;outchar r2, r0
	call RedesenhaCenario
	rts
	
DesenhaAlien:
	load r0, posAlien
	outchar r1, r0
	store posAlienAnt, r0
	rts

ApagaAlien:
	load r0, posAlienAnt
	;outchar r2, r0
	call RedesenhaCenario
	rts
	
DesenhaTiro:
	push r2
	push r3
	
	load r0, posTiro
	loadn r2, #40
	
	mod r3, r0, r2			; verifica se o tira esta na area segura, n desenhando ele
	loadn r2, #1
	cmp r3, r2
	jel SaiDesenhaTiro
	
	outchar r1, r0
	store posTiroAnt, r0
	
	SaiDesenhaTiro:
	pop r3
	pop r2
	rts

ApagaTiro: 
	load r0, posTiroAnt
	;outchar r2, r0
	call RedesenhaCenario
	rts
	
DesenhaTiroAlien:
	load r0, posTiroAlien
	outchar r1, r0
	store posTiroAntAlien, r0
	rts

ApagaTiroAlien: 
	load r0, posTiroAntAlien
	call RedesenhaCenario
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
	l02 : string "  Feito por: Luan Gustavo Orlandi       "
	l03 : string "             Henrique Pasquini Santos   "
	l04 : string "                                        "
	l05 : string "                                        "
	l06 : string "                                        "
	l07 : string "                JOGO                    "
	l08 : string "                                        "
	l09 : string "    |\\\\   || ||===|| ||   // ||====     "
	l10 : string "    ||\\\\  || ||   || ||  //  ||         "
	l11 : string "    || \\\\ || ||===|| || //   ||==       "
	l12 : string "    ||  \\\\|| ||   || ||//    ||         "
	l13 : string "    ||   \\\\| ||   || |//     ||====     "
	l14 : string "                                        "
	l15 : string "                                        "
	l16 : string "                                        "
	l17 : string "                                        "
	l18 : string " PRESSIONE QUALQUER TECLA PARA COMECAR  "
	l19 : string "                                        "
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
;						DELAY
;************************************************************************

Delay:
						;Utiliza Push e Pop para nao afetar os Registradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #1 ; a
   Delay_volta2:				; contador de tempo quebrado em duas partes (dois loops de decremento)
	Loadn R0, #64000	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

	
;************************************************************************
;						RECALCULA NAVE
;************************************************************************
RecalculaPos:
	push r0
	push r1
	push r2
	push r3
	
	load r0, posNave
	inchar r1
	loadn r2, #'a'
	cmp r1, r2
	jeq RecalculaPosA
	
	loadn r2, #'d'
	cmp r1, r2
	jeq RecalculaPosD
	
	loadn r2, #'w'
	cmp r1, r2
	jeq RecalculaPosW
	
	loadn r2, #'s'
	cmp r1, r2
	jeq RecalculaPosS
	
	loadn r2, #40		; verifica se esta na area segura, n podendo atirar
	loadn r3, #1
	mod r2, r0, r2
	cmp r2, r3
	jel RecalculaPosFim
	
	loadn r2, #' '
	cmp r1, r2
	jne RecalculaPosFim
	load r0, posNave
	store posTiro, r0
	
	RecalculaPosFim:
	store posNave, r0
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
RecalculaPosA:
	loadn r1, #40
	loadn r2, #0
	mod r1, r0, r1
	cmp r1, r2
	jeq RecalculaPosFim
	dec r0
	jmp RecalculaPosFim	
	
RecalculaPosD:
	loadn r1, #40
	loadn r2, #39
	mod r1, r0, r1
	cmp r1, r2
	jeq RecalculaPosFim
	inc r0
	jmp RecalculaPosFim
	
RecalculaPosW:
	loadn r1, #40
	cmp r0, r1
	jle RecalculaPosFim
	sub r0,r0,r1
	jmp RecalculaPosFim
	
RecalculaPosS:
	loadn r1, #1159
	cmp r0,r1
	jgr RecalculaPosFim
	loadn r1, #40
	add r0,r0,r1
	jmp RecalculaPosFim
	
;************************************************************************
;						RECALCULA ALIEN
;************************************************************************
RecalculaPosAlien:
	push r0
	push r1
	push r2
	push r3
	push r4
	load r0, posAlien
	loadn r2, #Rand
	load r1, IncRand
	add r2, r2, r1
	loadi r3, r2
	loadn r4, #30
	;loadn r1, #0
	;loadn r2, #30
	inc r1
	cmp r1, r3
	jne MoveAlienRecalculaPos_Skip
	loadn r1, #0
	MoveAlienRecalculaPos_Skip:
		store IncRand, r1
		
	;switch 0 a 7
	loadn r2, #0
	cmp r3, r2  ; se Rand = 0
	jne MoveAlienRecalculaPos_Case1
	loadn r1, #41
	sub r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case1:
	loadn r2, #1   ; se Rand = 1
	cmp r3, r2
	jne MoveAlienRecalculaPos_Case2
	loadn r1, #40
	sub r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case2:
	loadn r2, #2   ; se Rand = 2
	cmp r3, r2
	jne MoveAlienRecalculaPos_Case3
	loadn r1, #39
	sub r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case3:
	loadn r2, #3   ; se Rand = 3
	cmp r3, r2
	jne MoveAlienRecalculaPos_Case4
	loadn r1, #1
	sub r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case4:
	loadn r2, #4   ; se Rand = 4
	cmp r3, r2
	jne MoveAlienRecalculaPos_Case5
	loadn r1, #1
	add r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case5:
	loadn r2, #5   ; se Rand = 5
	cmp r3, r2
	jne MoveAlienRecalculaPos_Case6
	loadn r1, #39
	add r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case6:
	loadn r2, #6   ; se Rand = 6
	cmp r3, r2
	jne MoveAlienRecalculaPos_Case7
	loadn r1, #40
	add r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_Case7:
	loadn r1, #41
	add r0, r0, r1
	jmp MoveAlienRecalculaPos_FimSwitch
	
	MoveAlienRecalculaPos_FimSwitch:
	store posAlien, r0
	load r1, IncRand
	cmp r1, r4					; verifica se deve resetar o contador do Rand
	jeq Zera_IncRand
	Continue_MoveAlien:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
Zera_IncRand:
	loadn r1, #0
	store IncRand, r1
	jmp Continue_MoveAlien
	
;************************************************************************
;						RECALCULA TIRO
;************************************************************************
RecalculaPosTiro:
	push r0
	push r1
	push r2
	
	load r0, posTiro
	loadn r1, #40
	
	mod r2, r0, r1
	loadn r1, #0
	cmp r2, r1
	jeq ParaTiro
	inc r0

Continua:
	store posTiro, r0
	
	pop r2
	pop r1
	pop r0
	rts
	
ParaTiro:
	;loadn r0, #0
	jmp Continua
	
;************************************************************************
;						RECALCULA TIRO ALIEN
;************************************************************************
RecalculaPosTiroAlien:
	push r0
	push r1
	push r2
	load r0, posTiroAlien
	
	loadn r1, #40
	dec r0
	
	mod r1, r0, r1		; verifica se esta na borda esquerda
	loadn r2, #1
	cmp r1, r2
	jel AtiraNovamente
	
ContinuaTiroAlien:
	store posTiroAlien, r0
	pop r2
	pop r1
	pop r0
	rts
	
AtiraNovamente:
	load r0, posAlien
	dec r0
	jmp ContinuaTiroAlien
	
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
;						CARREGA CENARIO
;************************************************************************
; carrega um cenario diferente do anterior
CarregaCenario:
	push r0
	push r1

	load r0, CenarioAtual
	loadn r1, #1
	
	cmp r0, r1				; compara para ver ql cenario deve desenhar
	jeq Carrega01
	
	inc r1
	cmp r0, r1
	jeq Carrega02
	jmp Carrega03
	
	Carrega01:
		call CarregaCenario01
		
		inc r0
		store CenarioAtual, r0 ; troca o cenario que esta usando
		
		jmp SaiCarregaCenario
	
	Carrega02:
		call CarregaCenario02
		
		inc r0
		store CenarioAtual, r0 ; troca o cenario que esta usando
		
		jmp SaiCarregaCenario
	
	
	Carrega03:
		call CarregaCenario03
		
		loadn r0, #1
		store CenarioAtual, r0 ; troca o cenario que esta usand
		
		jmp SaiCarregaCenario
		
	SaiCarregaCenario:
		pop r0
		pop r1
		rts

;************************************************************************
;						CARREGA CENARIO 01
;************************************************************************
; carrega o cenario 1 no vetor Cenario
CarregaCenario01:
	push r0	
	push r1
	push r2
	
	loadn r1, #CenarioCor01		; cor azul para o cenario
	loadi r1, r1
	loadn r2, #Cenario				; contador da posicao de Cenario
	
	loadn r0, #Cenario01_linha01	; linha sendo lida
	call Carregalinha
	loadn r0, #Cenario01_linha02
	call Carregalinha
	loadn r0, #Cenario01_linha03
	call Carregalinha
	loadn r0, #Cenario01_linha04
	call Carregalinha
	loadn r0, #Cenario01_linha05
	call Carregalinha
	loadn r0, #Cenario01_linha06
	call Carregalinha
	loadn r0, #Cenario01_linha07
	call Carregalinha
	loadn r0, #Cenario01_linha08
	call Carregalinha
	loadn r0, #Cenario01_linha09
	call Carregalinha
	loadn r0, #Cenario01_linha10
	call Carregalinha
	loadn r0, #Cenario01_linha11
	call Carregalinha
	loadn r0, #Cenario01_linha12
	call Carregalinha
	loadn r0, #Cenario01_linha13
	call Carregalinha
	loadn r0, #Cenario01_linha14
	call Carregalinha
	loadn r0, #Cenario01_linha15
	call Carregalinha
	loadn r0, #Cenario01_linha16
	call Carregalinha
	loadn r0, #Cenario01_linha17
	call Carregalinha
	loadn r0, #Cenario01_linha18
	call Carregalinha
	loadn r0, #Cenario01_linha19
	call Carregalinha
	loadn r0, #Cenario01_linha20
	call Carregalinha
	loadn r0, #Cenario01_linha21
	call Carregalinha
	loadn r0, #Cenario01_linha22
	call Carregalinha
	loadn r0, #Cenario01_linha23
	call Carregalinha
	loadn r0, #Cenario01_linha24
	call Carregalinha
	loadn r0, #Cenario01_linha25
	call Carregalinha
	loadn r0, #Cenario01_linha26
	call Carregalinha
	loadn r0, #Cenario01_linha27
	call Carregalinha
	loadn r0, #Cenario01_linha28
	call Carregalinha
	loadn r0, #Cenario01_linha29
	call Carregalinha
	loadn r0, #Cenario01_linha30
	call Carregalinha
	
SaiCarregaCenario:
	pop r2
	pop r1
	pop r0
	rts

;************************************************************************
;						CARREGA CENARIO 02
;************************************************************************
; carrega o cenario 2 no vetor Cenario
CarregaCenario02:
	push r0	
	push r1
	push r2
	
	loadn r1, #CenarioCor02		; cor azul para o cenario
	loadi r1, r1
	loadn r2, #Cenario				; contador da posicao de Cenario
	
	loadn r0, #Cenario02_linha01	; linha sendo lida
	call Carregalinha
	loadn r0, #Cenario02_linha02
	call Carregalinha
	loadn r0, #Cenario02_linha03
	call Carregalinha
	loadn r0, #Cenario02_linha04
	call Carregalinha
	loadn r0, #Cenario02_linha05
	call Carregalinha
	loadn r0, #Cenario02_linha06
	call Carregalinha
	loadn r0, #Cenario02_linha07
	call Carregalinha
	loadn r0, #Cenario02_linha08
	call Carregalinha
	loadn r0, #Cenario02_linha09
	call Carregalinha
	loadn r0, #Cenario02_linha10
	call Carregalinha
	loadn r0, #Cenario02_linha11
	call Carregalinha
	loadn r0, #Cenario02_linha12
	call Carregalinha
	loadn r0, #Cenario02_linha13
	call Carregalinha
	loadn r0, #Cenario02_linha14
	call Carregalinha
	loadn r0, #Cenario02_linha15
	call Carregalinha
	loadn r0, #Cenario02_linha16
	call Carregalinha
	loadn r0, #Cenario02_linha17
	call Carregalinha
	loadn r0, #Cenario02_linha18
	call Carregalinha
	loadn r0, #Cenario02_linha19
	call Carregalinha
	loadn r0, #Cenario02_linha20
	call Carregalinha
	loadn r0, #Cenario02_linha21
	call Carregalinha
	loadn r0, #Cenario02_linha22
	call Carregalinha
	loadn r0, #Cenario02_linha23
	call Carregalinha
	loadn r0, #Cenario02_linha24
	call Carregalinha
	loadn r0, #Cenario02_linha25
	call Carregalinha
	loadn r0, #Cenario02_linha26
	call Carregalinha
	loadn r0, #Cenario02_linha27
	call Carregalinha
	loadn r0, #Cenario02_linha28
	call Carregalinha
	loadn r0, #Cenario02_linha29
	call Carregalinha
	loadn r0, #Cenario02_linha30
	call Carregalinha
	
SaiCarregaCenario:
	pop r2
	pop r1
	pop r0
	rts

;************************************************************************
;						CARREGA CENARIO 03
;************************************************************************
; carrega o cenario 3 no vetor Cenario
CarregaCenario03:
	push r0	
	push r1
	push r2
	
	loadn r1, #CenarioCor03		; cor azul para o cenario
	loadi r1, r1
	loadn r2, #Cenario				; contador da posicao de Cenario
	
	loadn r0, #Cenario03_linha01	; linha sendo lida
	call Carregalinha
	loadn r0, #Cenario03_linha02
	call Carregalinha
	loadn r0, #Cenario03_linha03
	call Carregalinha
	loadn r0, #Cenario03_linha04
	call Carregalinha
	loadn r0, #Cenario03_linha05
	call Carregalinha
	loadn r0, #Cenario03_linha06
	call Carregalinha
	loadn r0, #Cenario03_linha07
	call Carregalinha
	loadn r0, #Cenario03_linha08
	call Carregalinha
	loadn r0, #Cenario03_linha09
	call Carregalinha
	loadn r0, #Cenario03_linha10
	call Carregalinha
	loadn r0, #Cenario03_linha11
	call Carregalinha
	loadn r0, #Cenario03_linha12
	call Carregalinha
	loadn r0, #Cenario03_linha13
	call Carregalinha
	loadn r0, #Cenario03_linha14
	call Carregalinha
	loadn r0, #Cenario03_linha15
	call Carregalinha
	loadn r0, #Cenario03_linha16
	call Carregalinha
	loadn r0, #Cenario03_linha17
	call Carregalinha
	loadn r0, #Cenario03_linha18
	call Carregalinha
	loadn r0, #Cenario03_linha19
	call Carregalinha
	loadn r0, #Cenario03_linha20
	call Carregalinha
	loadn r0, #Cenario03_linha21
	call Carregalinha
	loadn r0, #Cenario03_linha22
	call Carregalinha
	loadn r0, #Cenario03_linha23
	call Carregalinha
	loadn r0, #Cenario03_linha24
	call Carregalinha
	loadn r0, #Cenario03_linha25
	call Carregalinha
	loadn r0, #Cenario03_linha26
	call Carregalinha
	loadn r0, #Cenario03_linha27
	call Carregalinha
	loadn r0, #Cenario03_linha28
	call Carregalinha
	loadn r0, #Cenario03_linha29
	call Carregalinha
	loadn r0, #Cenario03_linha30
	call Carregalinha
	
SaiCarregaCenario:
	pop r2
	pop r1
	pop r0
	rts

;************************************************************************
;						CARREGA LINHA
;************************************************************************
; carrega uma linha contida em r0, com cor r1, no Cenario (precisa carregar as 30 linhas para preencher o cenario todo)
Carregalinha:
	push r3
	push r4
	push r5
	
	loadn r4, #40				; final da string
	loadn r5, #0				; contador da posicao do vetor linha sendo lida

	LoopCarregalinha:
		cmp r5, r4
		jeq SaiLoopCarregalinha
		
		add r3, r5, r0			; posicao do vetor sendo lida
		loadi r3, r3			; carrega o caracte dessa posicao
		
		add r3, r3, r1			; soma com a cor
		
		storei r2, r3			; armazena em Cenario o caractere
		inc r2					; incrementa a posicao de Cenario

		inc r5					; incrementa o contador da posicao da linha
		jmp LoopCarregalinha
	
	SaiLoopCarregalinha:
		pop r5
		pop r4
		pop r3
		rts

;************************************************************************
;						DESENHA CENARIO
;************************************************************************
; desenha todo o cenario guardado no vetor Cenario
DesenhaCenario:
	push r0
	push r1
	push r2
	push r3
	
	loadn r0, #0				; counter da posicao sendo desenhada
	loadn r2, #1200			; canto direito de baixo da tela
	loadn r3, #Cenario			; carrega vetor
	
	LoopDesenhaCenario:
		cmp r0, r2
		jeg SaiLoopDesenhaCenario
		
		loadi r1, r3			; carrega o caractere do cenario
		inc r3
		
		outchar r1, r0
		
		inc r0					; incrementa contador
		jmp LoopDesenhaCenario
		
	SaiLoopDesenhaCenario:
		pop r3
		pop r2
		pop r1
		pop r0
		
		rts
		
;************************************************************************
;						REDESENHA CENARIO
;************************************************************************
; redesenha o caractere do cenario da posicao r0
RedesenhaCenario:
	push r1

	loadn r1, #Cenario			; carrega o cenario
	add r1, r1, r0				; pega a posicao do caractere que sera desenhado
	loadi r1, r1				; pega o caractere que sera desenhado
	
	outchar r1, r0				; desenha essa parte do cenario
	
	pop r1
	
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
	
	load r0, posTiroAlien
	load r1, posNave
	cmp r0, r1
	jeq VocePerdeu
	
	load r0, posAlien
	load r1, posTiro
	cmp r0, r1
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
	loadn r0, #53
	loadn r1, #m1
	call Imprime			; imprime string de vitoria
	
	jmp PerguntarNovoJogo
	
VocePerdeu:
	loadn r0, #53
	loadn r1, #m2
	call Imprime			; imprime string de derrota
	
	jmp PerguntarNovoJogo
	
PerguntarNovoJogo:
	loadn r0, #128
	loadn r1, #m3
	call Imprime			; imprime string de jogar de novo
	
	loadn r1, #'y'			; carrega as respostas validas
	loadn r2, #'n'
	
	LoopPerguntarNovoJogo:
		call DigitaLetra
		cmp r0, r1
		jeq ComecaNovoJogo			; se for sim
		cmp r0, r2
		jne LoopPerguntarNovoJogo	; se for algo diferente de 's' ou 'n'
	
	call LimpaTela					; se for nao
	halt
	
ComecaNovoJogo:
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