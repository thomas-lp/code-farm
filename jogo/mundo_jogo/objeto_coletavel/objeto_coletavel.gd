class_name ObjetoColetavel

extends StaticBody2D

@onready var _animador: AnimationPlayer = $Animador
@onready var _sprite: Sprite2D = $Sprite
@onready var _label_interacao: Label = $LabelInteracao

@export var item: Item

var _jogador_dentro: bool = false
var _interecao_em_execucao: bool = false

func _ready() -> void:
	add_to_group("ObjetosColetaveis")
	_preparar_estado_inicial()
	_label_interacao.hide()

func _preparar_estado_inicial():
	_label_interacao.hide()
	_label_interacao.global_position.y -= _sprite.region_rect.size.y + 16

func _process(delta: float) -> void:
	_se_houver_interacao()

func _se_houver_interacao() -> void:
	if _jogador_dentro and Input.is_action_just_pressed("interagir"):
		if Global.inventario.adicionar_item(item):
			_label_interacao.hide()
			_animador.play("coletar")
			await _animador.animation_finished
			queue_free()
		else:
			print("Inventário cheio!")

func _ao_detectar_entrada(area: Area2D) -> void:
	_label_interacao.show()
	_jogador_dentro = true
	_animador.play("destacar_objeto")

func _ao_detectar_saida(area: Area2D) -> void:
	_label_interacao.hide()
	_jogador_dentro = false
	_animador.play("RESET")
