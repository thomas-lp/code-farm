extends Node

var retomando_missao: bool = false

const CAMINHO_SAVE = "user://save_jogo.gd"
const QUANTIDADE_MISSOES = 5
const MISSAO_INICIAL = 1

var _save_jogo: SaveJogo
var missao_atual: int
var glossario: Glossario = Glossario.new()
var inventario: Inventario = Inventario.new()

# _________________________ GERENCIAMENTO DE SINAIS PROPAGADOS _________________________ #

signal novo_jogo
signal continuar_jogo
signal abrir_glossario
signal glossario_fechado
signal missao_fechada
signal missao_concluida
signal item_adicionado(pilha: PilhaItens)
signal solicitar_dados_requisicao
signal dados_requisicao_prontos(dados: Dictionary)

func conectar_sinal(no: Node, sinal: String, funcao: Callable) -> void:
	if no != null and not no.is_connected(sinal, funcao):
		no.connect(sinal, funcao)

func propagar_sinal(sinal: String, emissor: Node) -> void:
	if emissor == null:
		push_error("Tentativa de propagar sinal '%s' de um emissor nulo." % sinal)
		return

	var callback := func() -> void:
		if has_signal(sinal):
			emit_signal(sinal)
		else:
			push_error("Globals: sinal '%s' não declarado para propagação!" % sinal)

	var callable := Callable(callback)

	if not emissor.is_connected(sinal, callable):
		emissor.connect(sinal, callable)

# _________________________ GERENCIAMENTO DE MISSOES _________________________ #

func concluiu_todas_missoes() -> bool:
	return missao_atual > QUANTIDADE_MISSOES

# _________________________ GERENCIAMENTO DE SAVE _________________________ #

func salvar_jogo(posicao_player: Vector2) -> void:
	if not _save_jogo:
		print("Nenhum save encontrado. Criando novo save.")
		_save_jogo = SaveJogo.new()
	
	_save_jogo.missao_atual = missao_atual
	_save_jogo.player_posicao = posicao_player
	
	ResourceSaver.save(_save_jogo, CAMINHO_SAVE)
	print("Jogo salvo!")

func carregar_save() -> void:
	if ResourceLoader.exists(CAMINHO_SAVE):
		_save_jogo = ResourceLoader.load(CAMINHO_SAVE) as SaveJogo
		missao_atual = _save_jogo.missao_atual
		print("Save carregado! Missão:", missao_atual)
	else:
		print("Nenhum save encontrado. Criando novo save.")
		_save_jogo = SaveJogo.new()
		salvar_jogo(Vector2.ZERO)


#Estrutura do projeto:

#jogo
#|__ assets
	#|__ fontes ...
	#|__ imagens ...
	#|__ sons ...
#
#|__ gerenciador_jogo
	#|__ glossario 
		#|__ glossario.gd
	#|__ inventario
		#|__ inventario.gb
		#|__ item.gd
		#|__ pilha_itens.gd
	#|__ missoes
		#|__ roteiros
			#|__ missao1.gd
			#|__ missao2.gd
			#|__ ...
		#|__ gerenciador_missoes.gd
		#|__ resultado_api.gd
		#|__ roteiro_missao.gd
	#|__ save
		#|__ save_jogo.gd
	#|__ gerenciador_jogo.gd
	#|__ gerenciador_jogo.tscn
#
#|__ interface_jogo
	#|__ interface_glossario
		#|__ interface_glossario.gd
		#|__ interface_glossario.tscn
		#|__ botao_lista_glossario
			#|__ botao_lista_glossario.gd
			#|__ botao_lista_glossario.tscn
		#|__ textura_animada_interface
			#|__ textura_animada_interface.gd
			#|__ textura_animada_interface.tscn		
	#|__ interface_menu_inicial
		#|__ interface_menu_inicial.gd
		#|__ interface_menu_inicial.tscn
	#|__ interface_missao
		#|__ caixa_dialogo.gd
		#|__ editor_codigo.gd
		#|__ tooltip.gd
		#|__ python_syntax_highlighter.gd
		#|__ interface_missao.gd
		#|__ interface_missao.tscn
	#|__ interface_padrao
		#|__ slot_hotbar
			#|__ slot_hotbar.gd
			#|__ slot_hotbar.tscn
		#|__ hotbar.gd
		#|__ menu_superior.gd
		#|__ interface_padrao.tscn
	#|__ interface_jogo.gd
	#|__ interface_jogo.tscn 
#
#|__ mundo_jogo
	#|__ animacoes ...
	#|__ jogador
		#|__ jogador.gd
		#|__ jogador.tscn
	#|__ objeto_coletavel
		#|__ objetos ...
		#|__ objeto_coletavel.gd
		#|__ objeto_coletavel.tscn
	#|__ objeto_interativo
		#|__ objeto_interativo.gd
		#|__ objeto_interativo.tscn
	#|__ passagem
		#|__ passagem.gd
		#|__ passagem.tscn
	#|__ terrenos
		#|__ terreno_casa.gd
		#|__ terreno_fazenda.tscn
	#|__ mundo_jogo.gd
	#|__ mundo_jogo.tscn
#
#|__ global.gb
