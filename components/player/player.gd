@icon("res://assets/icon-godot-node/node-2D/icon_human_controller.png")

class_name Player
extends CharacterBody2D

@export var _move_action: GUIDEAction
@export_range(0.0, 100.0, 0.5) var _move_speed: float = 100.0

var _last_move_direction := Vector2.DOWN


func _on_idle_state_entered() -> void:
	if _last_move_direction == Vector2.DOWN or _last_move_direction == Vector2.UP:
		%AnimationPlayer.play("Movement/Idle" + ("Up" if _last_move_direction.y < 0 else "Down"))
	else:
		%AnimationPlayer.play("Movement/IdleSide")
		%Sprite2D.flip_h = true if _last_move_direction.x < 0 else false


func _on_idle_state_processing(_delta: float) -> void:
	if _move_action.is_triggered() and _move_action.value_axis_2d != Vector2.ZERO:
		%StateChart.send_event("moving")


func _on_walking_state_entered() -> void:
	if _move_action.value_axis_2d == Vector2.DOWN or _move_action.value_axis_2d == Vector2.UP:
		%AnimationPlayer.play(
			"Movement/Walk" + ("Up" if _move_action.value_axis_2d.y < 0 else "Down")
		)
	else:
		%AnimationPlayer.play("Movement/WalkSide")
		%Sprite2D.flip_h = true if _move_action.value_axis_2d.x < 0 else false
	_last_move_direction = _move_action.value_axis_2d


func _on_walking_state_processing(delta: float) -> void:
	if not _move_action.is_triggered() or _move_action.value_axis_2d == Vector2.ZERO:
		%StateChart.send_event("idle")
		return

	velocity = _move_action.value_axis_2d.normalized() * _move_speed
	move_and_slide()
