class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://gui/inventory-hud/inventory_slot.tscn")

@export var data: InventoryData


func _ready() -> void:
	clear_inventory()


func clear_inventory() -> void:
	for c in %GridContainer.get_children():
		c.queue_free()


func update_inventory() -> void:
	for s in data.slots:
		%GridContainer.add_child(INVENTORY_SLOT.instantiate())
