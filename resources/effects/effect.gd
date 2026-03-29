@abstract
@icon("res://assets/icon-godot-node/node/icon_card.png")
class_name Effect extends Resource

@export var name: String
@export_multiline() var description: String


func apply(_stats: StatSheet) -> void:
	assert(false, "method not implemented")
