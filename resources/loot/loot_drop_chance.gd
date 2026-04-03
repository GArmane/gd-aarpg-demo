@icon("res://assets/icon-godot-node/node/icon_crate.png")
class_name LootDropChance extends Resource

@export var item: Item
@export_range(0, 100, 5, "suffix:%") var probability: float = 100
@export_range(0, 100, 1, "suffix:items") var min_amount: int = 1:
	set(value):
		assert(value >= 0, "value should be positive")
		assert(value <= max_amount, "min_amount should be lower than max_amount")
		min_amount = value
@export_range(0, 100, 1, "suffix:items") var max_amount: int = 3:
	set(value):
		assert(value >= 0, "value should be positive")
		max_amount = value
		if min_amount > max_amount:
			min_amount = max_amount


func get_drop_count() -> int:
	return randi_range(min_amount, max_amount) if randf_range(0, 100) <= probability else 0
