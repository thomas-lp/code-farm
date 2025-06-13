class_name Hotbar

extends Control

@onready var _seletor: NinePatchRect = %Seletor
@onready var _grid: GridContainer = %GridContainer

var _slots: Array = []
var _indice_selecionado := 0 

func _ready():
	call_deferred("_atualizar_hotbar")

func _atualizar_hotbar():	
	while not is_visible_in_tree():
		await get_tree().process_frame
	
	_slots = _grid.get_children()
	atualizar_slots_com_dados_do_inventario()
	_atualizar_seletor()

func _process(_delta) -> void:
	for i in range(6):
		if Input.is_action_just_pressed("hotbar_" + str(i + 1)):
			_selecionar_slot(i)

func _selecionar_slot(indice: int) -> void:
	if indice >= 0 and indice < _slots.size():
		_indice_selecionado = indice
		_atualizar_seletor()

func _atualizar_seletor() -> void:
	var slot = _slots[_indice_selecionado]
	
	_seletor.global_position = slot.global_position
	_seletor.size = slot.size

func atualizar_slots_com_dados_do_inventario() -> void:
	for i in range(_slots.size()):
		var slot = _slots[i]
		
		if i < Global.inventario.slots.size():
			slot.atualizar_slot(Global.inventario.slots[i])
		else:
			slot.limpar_slot()

func _ao_mudar_visibilidade_interface_padrao() -> void:
	call_deferred("_atualizar_hotbar")


#func adicionar_item(item: Item) -> bool:
	## Tenta acumular
	#for slot in _slots:
		#if slot.pilha and slot.pilha.item == item:
			#slot.pilha.quantidade += 1
			#slot.atualizar_slot()
			#return true
#
	## Tenta novo slot
	#for slot in _slots:
		#if slot.pilha == null:
			#var nova_pilha = ItemStack.new()
			#nova_pilha.item = item
			#nova_pilha.quantidade = 1
			#slot.pilha = nova_pilha
			#slot.atualizar_slot()
			#return true
#
	#return false # Não há espaço
