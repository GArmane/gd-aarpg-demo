@icon("res://assets/icon-godot-node/node/icon_bag.png")
class_name Inventory extends Resource

signal item_activated(item: Item)

@export var _slots: Array[InventorySlot] = []
var slots: Array[InventorySlot]:
	get():
		return _slots.duplicate()


func activate_item(item: Item) -> Error:
	var slot = find_item_slot(item)
	if not slot:
		return ERR_DOES_NOT_EXIST
	if slot.item is Consumable:
		return _handle_consumable_item(slot)
	return _handle_generic_item(slot)


func add_item(item: Item, qtd: int = 1) -> Error:
	var item_slot = find_item_slot(item)
	if not item_slot:
		# Slot with item not found.
		var empty_slot := find_empty_slot()
		if not empty_slot:
			return FAILED
		empty_slot.item = item
		empty_slot.quantity += 1
	else:
		item_slot.quantity += qtd

	emit_changed()
	return OK


func find_item_slot(item: Item) -> InventorySlot:
	var idx := _slots.find_custom(func(slot): return slot.item == item)
	if idx == -1:
		return null
	return _slots[idx]


func find_empty_slot() -> InventorySlot:
	var idx := _slots.find_custom(func(sl): return sl.is_empty())
	if idx == -1:
		return null
	return _slots[idx]


func _handle_consumable_item(slot: InventorySlot) -> Error:
	if slot.quantity == 0:
		return ERR_UNAVAILABLE
	slot.quantity -= 1
	item_activated.emit(slot.item)
	emit_changed()
	return OK


func _handle_generic_item(_slot: InventorySlot) -> Error:
	return FAILED
