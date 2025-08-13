@icon("res://assets/icon-godot-node/node-2D/icon_human_controller.png")
class_name Player
extends CharacterBody2D

@export_range(0.0, 100.0, 0.5) var _move_speed: float = 100.0


func _process(delta: float) -> void:
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	dir.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	velocity = dir * _move_speed
	move_and_slide()
