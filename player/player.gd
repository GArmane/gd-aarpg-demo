@icon("res://assets/icon-godot-node/node-2D/icon_human_controller.png")
class_name Player
extends CharacterBody2D

@export var _move_action: GUIDEAction
@export_range(0.0, 100.0, 0.5) var _move_speed: float = 100.0


func _process(delta: float) -> void:
	velocity = _move_action.value_axis_2d * _move_speed
	move_and_slide()
