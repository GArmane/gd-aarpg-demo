@icon("res://assets/icon-godot-node/control/icon_grid.png")
class_name InventoryUI extends Control

signal no_button_selected
signal button_selected(ref: InventoryButton)

const INVENTORY_BUTTON := preload("res://gui/inventory-hud/inventory_button.tscn")

@export var data: Inventory:
	set(value):
		data = value
		_clear_grid()
		if data != null:
			for slot in data.slots:
				var button := INVENTORY_BUTTON.instantiate() as InventoryButton
				button.data = slot
				button.focus_entered.connect(button_selected.emit.bind(button))
				button.focus_exited.connect(no_button_selected.emit)
				%GridContainer.add_child(button)
			_set_last_focus.call_deferred()

var _focused_idx: int = -1


func _clear_grid():
	var children = %GridContainer.get_children()
	for idx in children.size():
		var child = children[idx]
		if child.has_focus():
			_focused_idx = idx
		child.queue_free()


func _set_last_focus():
	if _focused_idx >= 0:
		await get_tree().process_frame
		%GridContainer.get_children()[_focused_idx].grab_focus()
