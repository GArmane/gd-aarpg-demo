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


func _play_audio(audio: AudioStream, pitch_scale: float = 1.0) -> void:
	%AudioStreamPlayer2D.stream = audio
	%AudioStreamPlayer2D.pitch_scale = pitch_scale
	%AudioStreamPlayer2D.play()


func _update_movement_animation(anim_key: String) -> void:
	const DIRECTION_NAMES = {
		Vector2.RIGHT: "Side", Vector2.DOWN: "Down", Vector2.LEFT: "Side", Vector2.UP: "Up"
	}
	var mov_angle = (velocity.normalized() + _cardinal_direction * 0.1).angle()
	var mov_direc = DIRECTION_NAMES.keys()[round(mov_angle / TAU * DIRECTION_NAMES.size())]
	# Character changed movement or animation since last frame.
	if mov_direc != _cardinal_direction or anim_key not in %AnimationPlayer.current_animation:
		var anim_dir = DIRECTION_NAMES[mov_direc]
		%AnimationPlayer.play(anim_key + anim_dir)
		%Sprite2D.scale.x = -1 if mov_direc in [Vector2.LEFT, Vector2.DOWN] else 1
		_cardinal_direction = mov_direc


func _ready() -> void:
	GUIDE.enable_mapping_context(_game_mode)


func _on_idle_state_entered() -> void:
	_update_movement_animation("Movement/Idle")


func _on_idle_state_processing(delta: float) -> void:
	if _move_action.is_triggered() and _move_action.value_axis_2d != Vector2.ZERO:
		%StateChart.send_event("Walking")
	if _attack_action.is_triggered():
		%StateChart.send_event("Attacking")
	velocity -= velocity * _deacceleration_speed * delta
	move_and_slide()


func _on_walking_state_entered() -> void:
	_cardinal_direction = _move_action.value_axis_2d
	_update_movement_animation("Movement/Walk")


func _on_walking_state_processing(_delta: float) -> void:
	if not _move_action.is_triggered() or _move_action.value_axis_2d == Vector2.ZERO:
		%StateChart.send_event("Idle")
		return
	if _attack_action.is_triggered():
		%StateChart.send_event("Attacking")
		return
	# Changed direction sinced started moving.
	_update_movement_animation("Movement/Walk")
	velocity = _move_action.value_axis_2d.normalized() * _move_speed
	move_and_slide()


func _on_attacking_state_entered() -> void:
	_update_movement_animation("Attack/")
	_play_audio(_attack_sound, randf_range(0.9, 1.1))


func _on_attacking_state_processing(delta: float) -> void:
	velocity -= velocity * _deacceleration_speed * delta
	move_and_slide()
	await %AnimationPlayer.animation_finished
	if _move_action.is_triggered():
		%StateChart.send_event("Walking")
	else:
		%StateChart.send_event("Idle")
