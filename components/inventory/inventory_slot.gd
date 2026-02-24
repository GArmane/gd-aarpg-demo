@icon("res://assets/icon-godot-node/node/icon_square.png")
class_name InventorySlot extends Resource

@export var item: Item = null
@export_range(0, 255) var quantity: int = 0:
	set(value):
		quantity = clampi(value, 0, 255)
