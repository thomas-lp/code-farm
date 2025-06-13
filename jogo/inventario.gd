# Inventario.gd
class_name Inventario
extends Resource

@export var quantidade_max: int = 6
@export var slots: Array[ItemStack] = []

func adicionar_item(item: Item) -> bool:
	for stack in slots:
		var stack_temp = ItemStack.new()
		stack_temp.item = item
		if stack.pode_empilhar_com(stack_temp):
			stack.quantidade += 1
			return true
	
	if slots.size() < quantidade_max:
		var nova_stack := ItemStack.new()
		nova_stack.item = item
		nova_stack.quantidade = 1
		slots.append(nova_stack)
		return true
	
	return false
