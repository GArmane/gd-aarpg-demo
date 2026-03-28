@icon("res://assets/icon-godot-node/node/icon_square.png")
class_name InventorySlot extends Resource

signal activated

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


func activate() -> Error:
	if not item:
		return ERR_DOES_NOT_EXIST
	if item is Consumable:
		if quantity == 0:
			return ERR_UNAVAILABLE
		quantity -= 1
		activated.emit()
		emit_changed()
		return OK
	return FAILED


func is_empty() -> bool:
	return item == null
