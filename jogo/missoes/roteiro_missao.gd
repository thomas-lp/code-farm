class_name RoteiroMissao 

extends Node 

signal missao_concluida

# Referências que o GerenciadorJogo vai injetar
var mundo_jogo: MundoJogo
var interface_jogo: InterfaceJogo
var _interface_missao: InterfaceMissao

var _pausada: bool = false

func configurar(mundo_jogo: MundoJogo, interface_jogo: InterfaceJogo):
	self.mundo_jogo = mundo_jogo
	self.interface_jogo = interface_jogo
	
	_interface_missao = interface_jogo.obter_interface(interface_jogo.Interface.MISSAO)
	
	Global.conectar_sinal(Global, "abrir_glossario", Callable(self, "_pausar_missao"))
	Global.conectar_sinal(Global, "glossario_fechado", Callable(self, "_retomar_missao"))

# Método obrigatório a ser implementado pelas missões
func executar() -> void:
	pass

# Métodos utilitários básicos que o script pode usar
func dialogo(texto: String) -> void:
	await _interface_missao.exibir_dialogo(texto)

func codigo(texto: String) -> void:
	await _interface_missao.exibir_codigo(texto)

func esperar(segundos: float) -> void:
	await interface_jogo.get_tree().create_timer(segundos).timeout

func obter_codigo_analisado() -> ResultadoAPI:
	_interface_missao.ativar_editor_codigo()
	var resultado = await _interface_missao.obter_resultado_api()
	_interface_missao.desativar_editor_codigo()
	return resultado

func limpar_editor_codigo() -> void:
	_interface_missao.limpar_editor_codigo()

func _pausar_missao():
	_pausada = true

func _retomar_missao():
	_pausada = false

func aguardar_retomar() -> void:
	while _pausada:
		await interface_jogo.get_tree().process_frame
	
func concluir_missao():
	limpar_editor_codigo()
	missao_concluida.emit() 
	Global.propagar_sinal("missao_concluida", self)
