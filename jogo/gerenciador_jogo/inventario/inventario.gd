class_name Inventario

extends Resource

@export var quantidade_max: int = 6
@export var slots: Array[PilhaItens] = []

func adicionar_item(item: Item) -> bool:
	for pilha in slots:
		var pilha_temp = PilhaItens.new()
		pilha_temp.item = item
		if pilha.pode_empilhar_com(pilha_temp):
			pilha.quantidade += 1
			Global.emit_signal("item_adicionado", pilha)
			return true
	
	if slots.size() < quantidade_max:
		var nova_pilha := PilhaItens.new()
		nova_pilha.item = item
		nova_pilha.quantidade = 1
		slots.append(nova_pilha)
		Global.emit_signal("item_adicionado", nova_pilha) # <==== Aqui!
		return true
	
	return false
