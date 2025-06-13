class_name GerenciadorJogo 

extends Node

@onready var mundo_jogo: MundoJogo = $MundoJogo
@onready var interface_jogo: InterfaceJogo = $CanvasLayer/InterfaceJogo

@onready var _gerenciador_missoes: GerenciadorMissoes

func _ready() -> void:
	_gerenciador_missoes = GerenciadorMissoes.new()
	_gerenciador_missoes.configurar(mundo_jogo, interface_jogo)
	
	interface_jogo.exibir_interface(interface_jogo.Interface.MENU_INICIAL)
	
	Global.conectar_sinal(Global, "novo_jogo", Callable(self, "_ao_clicar_novo_jogo"))
	Global.conectar_sinal(Global, "continuar_jogo", Callable(self, "_ao_clicar_continuar_jogo"))
	Global.conectar_sinal(Global, "abrir_glossario", Callable(self, "_ao_clicar_botao_glossario"))
	Global.conectar_sinal(Global, "missao_fechada", Callable(self, "_ao_clicar_fechar_missao"))
	
func _ao_clicar_novo_jogo() -> void:
	Global.missao_atual = Global.MISSAO_INICIAL
	interface_jogo.exibir_interface(interface_jogo.Interface.PADRAO)
	_gerenciador_missoes.executar()

func _ao_clicar_continuar_jogo() -> void:
	Global.carregar_save()
	interface_jogo.exibir_interface(interface_jogo.Interface.PADRAO)
	_gerenciador_missoes.executar()

func _ao_clicar_botao_glossario() -> void:
	mundo_jogo.desativar_movimento_jogador()

	var interface_anterior: InterfaceJogo.Interface = interface_jogo.obter_interface_atual()
	interface_jogo.exibir_interface(InterfaceJogo.Interface.GLOSSARIO)

	await Global.glossario_fechado

	interface_jogo.exibir_interface(interface_anterior)
	mundo_jogo.ativar_movimento_jogador()

func _ao_clicar_fechar_missao() -> void:
	mundo_jogo.ativar_movimento_jogador()
	interface_jogo.exibir_interface(InterfaceJogo.Interface.PADRAO)
