class_name MundoJogo

extends Node2D

@onready var _transicao_cenario: TransicaoCenario = $CanvasLayer/TransicaoCenario
@onready var _jogador: Jogador = $Jogador

var _terreno_atual: Node2D = null

func _ready():
	_conectar_passagens()

func _conectar_passagens():
	for passagem in get_tree().get_nodes_in_group("Passagens"):
		Global.conectar_sinal(passagem, "jogador_passou_passagem", Callable(self, "_ao_jogador_passar_passagem"))

func _ao_jogador_passar_passagem(terreno_destino: String, passagem_destino: String):
	_transicao_cenario.iniciar_transicao(Callable(self, "_trocar_posicao_do_jogador").bind(terreno_destino, passagem_destino))

func _trocar_posicao_do_jogador(terreno_destino: String, passagem_destino: String):
	_jogador.desativar_camera()	
	_jogador.desativar_movimento()	
	
	_terreno_atual = find_child(terreno_destino)
	var nova_passagem = _terreno_atual.find_child(passagem_destino, true, true)
	_jogador.global_position = nova_passagem.obter_posicao_spawn()

	await get_tree().create_timer(0.1).timeout
	
	Global.conectar_sinal(_transicao_cenario, "transicao_finalizada", Callable(self, "_reativar_camera_apos_transicao"))

func _reativar_camera_apos_transicao():
	_jogador.ativar_camera()
	_jogador.ativar_movimento()	

func ativar_movimento_jogador():
	_jogador.ativar_movimento()
	
func desativar_movimento_jogador():
	_jogador.desativar_movimento()

func obter_jogador() -> Jogador:
	return find_child("Jogador", true, false)

func obter_objeto_interativo_atual() -> ObjetoInterativo:
	return find_child("Missao%d" % Global.missao_atual, true, false)

func obter_elemento(nome: String):
	return find_child(nome, true, true)


# _________________________ GERENCIAMENTO DE TERRENOS _________________________ #

#const CAMINHO_TERRENO_CASA = preload("res://mundo_jogo/terreno/terreno_casa.tscn")
#const CAMINHO_TERRENO_FAZENDA = preload("res://mundo_jogo/terreno/terreno_fazenda.tscn")
#var _passagem_spawn: String
#
#func obter_caminho_terreno(nome_terreno: String) -> PackedScene:
	#match nome_terreno:
		#"TerrenoFazenda":
			#return CAMINHO_TERRENO_FAZENDA
		#"TerrenoCasa":
			#return CAMINHO_TERRENO_CASA
	#return null
