class_name TextoPlaca
extends Control

@onready var _texto = %Texto

var _flutuando := false
var _tempo := 0.0
var _posicao_base := Vector2.ZERO

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if _flutuando:
		_tempo += delta
		var deslocamento = sin(_tempo * 2.0) * 4.0 
		position.y = _posicao_base.y + deslocamento

func exibir(texto: String, posicao: Vector2) -> void:
	_texto.text = texto
	show()

	global_position = posicao - Vector2(0, size.y + 10)
	_posicao_base = position
	_tempo = 0.0
	_flutuando = true

func esconder() -> void:
	_flutuando = false
	hide()
