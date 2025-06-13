extends Node

const CAMINHO_SAVE = "user://save_jogo.gd"
const QUANTIDADE_MISSOES = 4
const MISSAO_INICIAL = 4

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
