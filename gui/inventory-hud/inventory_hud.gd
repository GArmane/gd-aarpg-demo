class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://gui/inventory-hud/inventory_slot.tscn")

@export var data: InventoryData:
	set(value):
		data = value
		update_inventory()


func _ready() -> void:
	clear_inventory()


func clear_inventory() -> void:
	for c in %GridContainer.get_children():
		c.queue_free()


func update_inventory() -> void:
	for slot in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		new_slot.data = slot
		%GridContainer.add_child(new_slot)
