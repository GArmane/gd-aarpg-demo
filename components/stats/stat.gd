@icon("res://assets/icon-godot-node/node/icon_stat.png")
class_name Stat extends Resource

@export var value: Variant:
	set(n_val):
		value = n_val
		emit_changed()


func initialize(n_value: Variant):
	value = n_value
	return self
