class_name MenuSuperior 

extends Control

signal abrir_glossario

@onready var botao_glossario: Button = $MarginContainer/VBoxContainer/BotaoGlossario

func _ready() -> void:
	Global.propagar_sinal("abrir_glossario", self)

func _ao_clicar_botao_glossario() -> void:
	emit_signal("abrir_glossario")
