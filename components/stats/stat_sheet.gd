@icon("res://assets/icon-godot-node/node/icon_parchment.png")
class_name StatSheet extends Node

#region Signals
signal changed
#endregion

#region Attributes
@export_range(0, 20) var health_points: int:
	set(value):
		health_points = value
		changed.emit()
@export_range(0, 20) var max_health_points: int:
	set(value):
		assert(value >= 0, "max_health_points should not be negative")
		max_health_points = value
		changed.emit()
@export_range(0.0, 100.0, 0.5) var move_speed: float:
	set(value):
		assert(value >= 0, "move_speed should not be less than 0.")
		move_speed = value
		changed.emit()
@export_range(0.0, 100.0, 0.5) var deacceleration_speed: float:
	set(value):
		assert(value >= 0, "deacceleration_speed should not be less than 0.")
		deacceleration_speed = value
		changed.emit()
@export_range(0, 10) var base_damage: int:
	set(value):
		assert(value >= 0, "base_damage should not be less than 0.")
		base_damage = value
		changed.emit()
@export_range(0, 500.0, 0.5) var knockback_force: float:
	set(value):
		assert(value >= 0, "knockback_force should not be less than 0.")
		knockback_force = value
		changed.emit()
#endregion

#region Derived Attributes
var damage: int:
	get():
		return base_damage
#endregion


#region Health points functions.
func apply_damage(qtd: int) -> void:
	health_points -= abs(qtd)
#endregion
