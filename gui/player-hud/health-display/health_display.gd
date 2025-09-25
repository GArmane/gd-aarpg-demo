extends Control

@onready var _heart_component := preload("res://gui/player-hud/health-display/heart.tscn")


func set_health_points(value: int) -> void:
	var hearts = %IconContainer.get_children()
	for index in hearts.size():
		hearts[index].frame = clampi(
			value - index * 2, HeartGUIElement.State.EMPTY, HeartGUIElement.State.FULL
		)


func set_max_health_points(value: int) -> Array:
	assert(value >= 0, "Max health points should not be negative")
	_reset_icons()
	var count := roundi(value * 0.5)
	for i in count:
		%IconContainer.add_child(_heart_component.instantiate())
	return %IconContainer.get_children()


func _reset_icons() -> void:
	for icon in %IconContainer.get_children():
		icon.free()
