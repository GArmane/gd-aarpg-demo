@icon("res://assets/icon-godot-node/node/icon_bag.png")
class_name Inventory extends Resource

@export var slots: Array[InventorySlot] = []


func add_item(item: Item, qtd: int = 1) -> Error:
	var idx := slots.find_custom(func(slot): return slot.item == item)
	if idx == -1:
		# Slot with item not found.
		var empty_slot_idx := slots.find_custom(func(sl): return sl.is_empty())
		if empty_slot_idx == -1:
			# No empty slot found.
			return Error.FAILED
		# Empty slot found.
		# Add it to slot and update quantity.
		slots[empty_slot_idx].item = item
		slots[empty_slot_idx].quantity += qtd
	else:
		# Slot with item found.
		# Just update quantity.
		slots[idx].quantity += qtd
	emit_changed()
	return OK
