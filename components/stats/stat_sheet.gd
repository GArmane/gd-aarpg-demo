@icon("res://assets/icon-godot-node/node/icon_parchment.png")
class_name StatSheet extends Node

#region Signals
signal health_points_changed(value)
signal max_health_points_changed(value)
#endregion

#region Attributes
@export var health_points: Stat
@export var max_health_points: Stat
@export var move_speed: Stat
@export var deacceleration_speed: Stat
#endregion


#region Engine callbacks
func _ready():
	health_points.changed.connect(func(): health_points_changed.emit(health_points.value))
	health_points.changed.connect(func(): max_health_points_changed.emit(health_points.value))


#endregion


#region Builders
func set_hp(hp: int, max_hp: int) -> StatSheet:
	assert(hp <= max_hp, "health points should not be greater than maximum health points")
	assert(max_hp >= 0, "max health points should not be negative")

	health_points = Stat.new().initialize(hp)
	health_points.changed.connect(func(): health_points_changed.emit(health_points.value))

	max_health_points = Stat.new().initialize(max_hp)
	max_health_points.changed.connect(
		func(): max_health_points_changed.emit(max_health_points.value)
	)
	return self


func set_move_speed(value: float = 100.0) -> StatSheet:
	assert(value >= 0, "move speed should not be less than 0.")
	move_speed = Stat.new().initialize(value)
	return self


func set_deacceleration_speed(value: float = 10.0) -> StatSheet:
	assert(value >= 0, "deacceleration speed should not be less than 0.")
	deacceleration_speed = Stat.new().initialize(value)
	return self


#endregion


#region Health points functions.
func apply_damage(qtd: int) -> void:
	health_points.value -= abs(qtd)
#endregion
