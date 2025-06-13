class_name ItemStack

extends Resource

@export var item: Item
@export var quantidade: int = 1

func pode_empilhar_com(outro: ItemStack) -> bool:
	return item == outro.item and item.pode_empilhar
