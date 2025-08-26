@icon("res://assets/icon-godot-node/node-2D/icon_human_controller.png")

class_name Player
extends CharacterBody2D

@export var _move_action: GUIDEAction
@export_range(0.0, 100.0, 0.5) var _move_speed: float = 100.0

var _cardinal_direction := Vector2.DOWN


func _update_animation(anim: String) -> void:
	if _cardinal_direction.x != 0:
		%Sprite2D.scale.x = _cardinal_direction.x
	var anim_direction = (
		"Down"
		if _cardinal_direction == Vector2.DOWN
		else "Up" if _cardinal_direction == Vector2.UP else "Side"
	)
	%AnimationPlayer.play(anim + anim_direction)


func _on_idle_state_entered() -> void:
	velocity = Vector2.ZERO
	_update_animation("Movement/Idle")


func _on_idle_state_processing(_delta: float) -> void:
	if _move_action.is_triggered() and _move_action.value_axis_2d != Vector2.ZERO:
		%StateChart.send_event("Walking")


func _on_walking_state_entered() -> void:
	_cardinal_direction = _move_action.value_axis_2d
	_update_animation("Movement/Walk")


func _on_walking_state_processing(_delta: float) -> void:
	# Stopped moving.
	if not _move_action.is_triggered() or _move_action.value_axis_2d == Vector2.ZERO:
		%StateChart.send_event("Idle")
		return
	# Changed direction sinced started moving.
	if _cardinal_direction != _move_action.value_axis_2d:
		_cardinal_direction = _move_action.value_axis_2d
		_update_animation("Movement/Walk")
	velocity = _move_action.value_axis_2d.normalized() * _move_speed
	move_and_slide()


func _on_attacking_state_entered() -> void:
	%AnimationPlayer.play("Attack/Down")
