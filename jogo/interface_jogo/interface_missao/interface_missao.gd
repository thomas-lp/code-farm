class_name InterfaceMissao

extends Control

@onready var _caixa_dialogo: Control = %CaixaDialogo
@onready var _editor_codigo: Control = %EditorCodigo
@onready var _tooltip: Control = %Tooltip
@onready var _botao_fechar: Button = %BotaoFechar

signal missao_fechada

#Temporariamente o personagem e a foto serão estáticos. 
#Incorporar futuramente nos roteiros metodos para alternar personagens e fotos
var foto = "res://assets/imagens/Tiny Wonder Forest/characters/main character old/portrait female.png"
var personagem = "Thais"

func _ready() -> void:
	Global.propagar_sinal("missao_fechada", self)

func exibir_dialogo(texto: String) -> void: 
	await _caixa_dialogo.exibir_dialogo(texto, foto, personagem, _caixa_dialogo.TipoDeDialogo.DIALOGO)

func exibir_codigo(texto: String) -> void:
	await _caixa_dialogo.exibir_dialogo(texto, foto, personagem, _caixa_dialogo.TipoDeDialogo.CODIGO)

func limpar_editor_codigo() -> void:
	_editor_codigo.limpar()

func ativar_editor_codigo() -> void:
	_editor_codigo.ativar()

func desativar_editor_codigo() -> void:
	_editor_codigo.desativar()

func obter_resultado_api() -> ResultadoAPI:
	return await _editor_codigo.obter_resultado_api() 

func _ao_passar_mouse_termo(meta: Variant):
	var termo = str(meta)
	if Global.glossario.possui_termo(termo):
		var dados = Global.glossario.obter_dados_termo(termo)
		_tooltip.exibir(dados["nome"], dados["descricao"], dados["exemplo"])

func _ao_tirar_mouse_termo(meta: Variant):
	var _termo = str(meta)
	_tooltip.esconder()

func _ao_clicar_fechar_missao():
	hide()
	
	_caixa_dialogo.parar_som()
		
	emit_signal("missao_fechada")
