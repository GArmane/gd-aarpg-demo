@icon("res://assets/icon-godot-node/node/icon_square.png")
class_name InventorySlot extends Resource

const MAX_ITEM_STACK := 255
const MIN_ITEM_STACK := 0

@export var item: Item:
	set(value):
		item = value
		quantity = MIN_ITEM_STACK

@export_range(MIN_ITEM_STACK, MAX_ITEM_STACK) var quantity: int:
	set(value):
		quantity = clampi(value, MIN_ITEM_STACK, MAX_ITEM_STACK)
		emit_changed()

var description:
	get():
		return item.description if !is_empty() else ""


func is_empty() -> bool:
	return item == null
