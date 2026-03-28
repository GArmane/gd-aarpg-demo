@icon("res://assets/icon-godot-node/node/icon_bag.png")
class_name Inventory extends Node

signal changed
signal slot_activated(slot: InventorySlot)

@export var _slots: Array[InventorySlot] = []
var slots: Array[InventorySlot]:
	get():
		return _slots.duplicate()


func add_item(item: Item, qtd: int = 1) -> Error:
	var item_slot = find_item_slot(item)
	if not item_slot:
		# Slot with item not found.
		var empty_slot := find_empty_slot()
		if not empty_slot:
			return FAILED
		empty_slot.item = item
		empty_slot.quantity += 1
		empty_slot.activated.connect(slot_activated.emit.bind(empty_slot))
		empty_slot.changed.connect(changed.emit)
	else:
		item_slot.quantity += qtd
	changed.emit()
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
