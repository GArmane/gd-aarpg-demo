@icon("res://assets/icon-godot-node/node-2D/icon_character.png")

class_name Actor2D extends CharacterBody2D

signal cardinal_direction_changed(old_value, new_value)

const CARDINAL_DIRECTION = {
	Vector2.RIGHT: "Side",
	Vector2.DOWN: "Down",
	Vector2.LEFT: "Side",
	Vector2.UP: "Up",
}

var cardinal_direction := Vector2.DOWN:
	set(value):
		var old_cardinal_direction = cardinal_direction
		cardinal_direction = _angle_to_cardinal_direction(value.angle())
		cardinal_direction_changed.emit(old_cardinal_direction, cardinal_direction)


func apply_force(direction: Vector2, force: float, new_cardinal_direction := Vector2.ZERO) -> void:
	velocity = direction.normalized() * force
	if new_cardinal_direction != Vector2.ZERO:
		cardinal_direction = new_cardinal_direction


func update_animation(anim_key):
	var anim_dir = CARDINAL_DIRECTION[cardinal_direction]
	if (anim_key + anim_dir) not in %AnimationPlayer.current_animation:
		%AnimationPlayer.play(anim_key + anim_dir)
	%Sprite2D.scale.x = -1 if cardinal_direction in [Vector2.LEFT, Vector2.DOWN] else 1


func update_movement(
	delta: float,
	move_speed: float,
	deacceleration_speed: float,
	direction := Vector2.ZERO,
) -> Vector2:
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * move_speed

	velocity -= velocity * deacceleration_speed * delta
	move_and_slide()

	var mov_angle = (velocity.normalized() + cardinal_direction * 0.1).angle()
	var mov_direc = _angle_to_cardinal_direction(mov_angle)
	if mov_direc != cardinal_direction:
		cardinal_direction = mov_direc

	return velocity


func _angle_to_cardinal_direction(angle: float) -> Vector2:
	return CARDINAL_DIRECTION.keys()[round(angle / TAU * CARDINAL_DIRECTION.size())]
