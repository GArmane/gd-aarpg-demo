class_name Stat extends Resource

signal stat_changed(value: Variant)

@export var base_value: Variant:
	set(value):
		base_value = value
		stat_changed.emit(base_value)


func _init(p_base_value: Variant = null):
	base_value = p_base_value
