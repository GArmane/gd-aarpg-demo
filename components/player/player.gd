@icon("res://assets/icon-godot-node/node-2D/icon_human_controller.png")

class_name Player
extends CharacterBody2D

@export var _game_mode: GUIDEMappingContext
@export var _move_action: GUIDEAction
@export var _attack_action: GUIDEAction
@export var _attack_sound: AudioStream
@export_range(0.0, 100.0, 0.5) var _move_speed: float = 100.0
@export_range(0.0, 20.0, 0.5) var _deacceleration_speed: float = 10.0

var _cardinal_direction := Vector2.DOWN


func _ready() -> void:
	GUIDE.enable_mapping_context(_game_mode)


func _play_audio(audio: AudioStream, pitch_scale: float = 1.0) -> void:
	%AudioStreamPlayer2D.stream = audio
	%AudioStreamPlayer2D.pitch_scale = pitch_scale
	%AudioStreamPlayer2D.play()


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
	_update_animation("Movement/Idle")


func _on_idle_state_processing(delta: float) -> void:
	if _move_action.is_triggered() and _move_action.value_axis_2d != Vector2.ZERO:
		%StateChart.send_event("Walking")
	if _attack_action.is_triggered():
		%StateChart.send_event("Attacking")
	velocity -= velocity * _deacceleration_speed * delta
	move_and_slide()


func _on_walking_state_entered() -> void:
	_cardinal_direction = _move_action.value_axis_2d
	_update_animation("Movement/Walk")


func _on_walking_state_processing(_delta: float) -> void:
	if not _move_action.is_triggered() or _move_action.value_axis_2d == Vector2.ZERO:
		%StateChart.send_event("Idle")
		return
	if _attack_action.is_triggered():
		%StateChart.send_event("Attacking")
		return
	# Changed direction sinced started moving.
	if _cardinal_direction != _move_action.value_axis_2d:
		_cardinal_direction = _move_action.value_axis_2d
		_update_animation("Movement/Walk")
	velocity = _move_action.value_axis_2d.normalized() * _move_speed
	move_and_slide()


func _on_attacking_state_entered() -> void:
	_update_animation("Attack/")
	_play_audio(_attack_sound, randf_range(0.9, 1.1))


func _on_attacking_state_processing(delta: float) -> void:
	velocity -= velocity * _deacceleration_speed * delta
	move_and_slide()
	await %AnimationPlayer.animation_finished
	if _move_action.is_triggered():
		%StateChart.send_event("Walking")
	else:
		%StateChart.send_event("Idle")
