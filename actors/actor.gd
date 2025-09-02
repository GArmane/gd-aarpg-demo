@icon("res://assets/icon-godot-node/node-2D/icon_character.png")

class_name Actor2D extends CharacterBody2D

signal cardinal_direction_changed(old_dir, new_dir)

const DIRECTION_NAMES = {
	Vector2.RIGHT: "Side",
	Vector2.DOWN: "Down",
	Vector2.LEFT: "Side",
	Vector2.UP: "Up",
}

@export_range(0.0, 100.0, 0.5) var move_speed: float = 100.0
@export_range(0.0, 20.00, 0.5) var deacceleration_speed: float = 10.0

var _cardinal_direction := Vector2.DOWN


func play_audio(audio: AudioStream, pitch_scale: float = 1.0) -> void:
	%AudioStreamPlayer2D.stream = audio
	%AudioStreamPlayer2D.pitch_scale = pitch_scale
	%AudioStreamPlayer2D.play()


func update_animation(anim_key):
	var anim_dir = DIRECTION_NAMES[_cardinal_direction]
	if (anim_key + anim_dir) not in %AnimationPlayer.current_animation:
		%AnimationPlayer.play(anim_key + anim_dir)
	%Sprite2D.scale.x = -1 if _cardinal_direction in [Vector2.LEFT, Vector2.DOWN] else 1


func update_movement(delta, direction := Vector2.ZERO) -> Vector2:
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * move_speed

	velocity -= velocity * deacceleration_speed * delta
	move_and_slide()

	var mov_angle = (velocity.normalized() + _cardinal_direction * 0.1).angle()
	var mov_direc = DIRECTION_NAMES.keys()[round(mov_angle / TAU * DIRECTION_NAMES.size())]
	if mov_direc != _cardinal_direction:
		var old_cardinal_direction = _cardinal_direction
		_cardinal_direction = mov_direc
		cardinal_direction_changed.emit(old_cardinal_direction, _cardinal_direction)

	return velocity
