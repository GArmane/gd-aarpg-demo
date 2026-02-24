@icon("res://assets/icon-godot-node/control/icon_bag.png")
class_name InventoryUI extends Control

signal no_item_selected
signal item_selected(ref: InventoryButton)

const INVENTORY_BUTTON = preload("res://gui/inventory-hud/inventory_button.tscn")

@export var data: Inventory:
	set(value):
		data = value
		if data == null:
			return
		for slot in data.slots:
			var button = INVENTORY_BUTTON.instantiate()
			button.data = slot
			button.focus_entered.connect(func(): item_selected.emit(button))
			button.focus_exited.connect(func(): no_item_selected.emit())
			%GridContainer.add_child(button)


func _ready() -> void:
	for child in %GridContainer.get_children():
		child.queue_free()
