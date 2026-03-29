@icon("res://assets/icon-godot-node/node/icon_potion.png")
class_name Consumable extends Item

@export var effects: Array[Effect] = []


func apply(stats: StatSheet) -> void:
	for effect in effects:
		effect.apply(stats)
