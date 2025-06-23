class_name ObjetoColetavel

extends StaticBody2D

@onready var _animador: AnimationPlayer = $Animador
@onready var _sprite: Sprite2D = $Sprite
@onready var _label_interacao: Label = $LabelInteracao

@export var item: Item

var _jogador_dentro: bool = false
var _interacao_em_execucao: bool = false

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
	if _jogador_dentro and Input.is_action_just_pressed("interagir") and not _interacao_em_execucao:
		_interacao_em_execucao = true
		print("[OBJETO] Tentando coletar item:", item)
		
		if item != null:
			print("[OBJETO] Nome do item:", item.nome)
		else:
			print("[OBJETO] ERRO: item é nulo!")

		if Global.inventario.adicionar_item(item):
			_label_interacao.hide()
			_animador.play("coletar")
			await _animador.animation_finished
			queue_free()
		else:
			print("Inventário cheio!")
			_interacao_em_execucao = false

func _ao_detectar_entrada(corpo: Node2D) -> void:
	if corpo.is_in_group("Jogador"):
		_label_interacao.show()
		_jogador_dentro = true
		_animador.play("destacar_objeto")

func _ao_detectar_saida(corpo: Node2D) -> void:
	if corpo.is_in_group("Jogador"):
		_label_interacao.hide()
		_jogador_dentro = false
		_animador.play("RESET")
