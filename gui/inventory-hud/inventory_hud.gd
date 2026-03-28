@icon("res://assets/icon-godot-node/control/icon_grid.png")
class_name InventoryUI extends Control

signal no_button_selected
signal buttom_selected(ref: InventoryButton)
signal buttom_activated(ref: InventoryButton)

const INVENTORY_BUTTON := preload("res://gui/inventory-hud/inventory_button.tscn")

@export var data: Inventory:
	set(value):
		data = value
		for child in %GridContainer.get_children():
			child.queue_free()
		if data != null:
			for slot in data.slots:
				var button := INVENTORY_BUTTON.instantiate() as InventoryButton
				button.data = slot
				button.focus_exited.connect(func(): no_button_selected.emit())
				button.focus_entered.connect(func(): buttom_selected.emit(button))
				button.pressed.connect(func(): buttom_activated.emit(button))
				%GridContainer.add_child(button)
