@icon("res://assets/icon-godot-node/control/icon_bag.png")
class_name InventoryUI extends Control

const SLOT = preload("res://gui/inventory-hud/inventory_slot.tscn")

@export var data: Inventory:
	set(value):
		data = value
		if data == null:
			return
		for slot in data.slots:
			var new_slot = SLOT.instantiate()
			new_slot.data = slot
			%GridContainer.add_child(new_slot)


func _ready() -> void:
	for c in %GridContainer.get_children():
		c.queue_free()
