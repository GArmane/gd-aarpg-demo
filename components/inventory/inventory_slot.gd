@icon("res://assets/icon-godot-node/node/icon_square.png")
class_name InventorySlot extends Resource

const MAX_ITEM_STACK := 255
const MIN_ITEM_STACK := 0

@export var item: Item = null:
	set(value):
		item = value
		quantity = MIN_ITEM_STACK
@export_range(MIN_ITEM_STACK, MAX_ITEM_STACK) var quantity: int = MIN_ITEM_STACK:
	set(value):
		quantity = clampi(value, MIN_ITEM_STACK, MAX_ITEM_STACK)

var description:
	get():
		return item.description if !is_empty() else ""


func empty() -> void:
	item = null


func is_empty() -> bool:
	return item == null
