@icon("res://assets/icon-godot-node/node/icon_bag.png")
class_name Inventory extends Node

signal changed
signal slot_activated(slot: InventorySlot)

@export var _slots: Array[InventorySlot] = []
var slots: Array[InventorySlot]:
	get():
		return _slots.duplicate()


func _ready() -> void:
	for slot in slots:
		slot.changed.connect(changed.emit)
		slot.activated.connect(_on_inventory_slot_activated.bind(slot))
		slot.depleted.connect(_on_inventory_slot_depleted.bind(slot))


func add_item(item: Item, qtd: int = 1) -> Error:
	var item_slot = find_item_slot(item)
	if not item_slot:
		# Slot with item not found.
		var empty_slot := find_empty_slot()
		if not empty_slot:
			return FAILED
		empty_slot.item = item
	else:
		item_slot.quantity += qtd
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


func _on_inventory_slot_activated(slot: InventorySlot) -> void:
	slot_activated.emit()
	if slot.item.use_audio:
		EventBus.request_play_gui_audio.emit(slot.item.use_audio)


func _on_inventory_slot_depleted(slot: InventorySlot) -> void:
	slot.empty()
