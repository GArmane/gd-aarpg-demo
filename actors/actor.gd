@icon("res://assets/icon-godot-node/node-2D/icon_character.png")

class_name Actor2D extends CharacterBody2D

signal cardinal_direction_changed(old_value, new_value)
signal hitpoints_changed(old_value, new_value)

@export_category("Movement")
@export_range(0.0, 100.0, 0.5) var move_speed: float = 100.0
@export_range(0.0, 20.00, 0.5) var deacceleration_speed: float = 10.0

@export_category("Stats")
@export var hitpoints := 1:
	set(value):
		var old_value = hitpoints
		hitpoints = value
		hitpoints_changed.emit(old_value, hitpoints)

var cardinal_direction := Vector2.DOWN:
	set(value):
		var old_cardinal_direction = cardinal_direction
		cardinal_direction = MovementUtils.angle_to_cardinal_direction(value.angle())
		cardinal_direction_changed.emit(old_cardinal_direction, cardinal_direction)


func update_animation(anim_key):
	var anim_dir = MovementUtils.CARDINAL_DIRECTION[cardinal_direction]
	if (anim_key + anim_dir) not in %AnimationPlayer.current_animation:
		%AnimationPlayer.play(anim_key + anim_dir)
	%Sprite2D.scale.x = -1 if cardinal_direction in [Vector2.LEFT, Vector2.DOWN] else 1


func update_movement(delta: float, direction := Vector2.ZERO) -> Vector2:
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * move_speed

	velocity -= velocity * deacceleration_speed * delta
	move_and_slide()

	var mov_angle = (velocity.normalized() + cardinal_direction * 0.1).angle()
	var mov_direc = MovementUtils.angle_to_cardinal_direction(mov_angle)
	if mov_direc != cardinal_direction:
		cardinal_direction = mov_direc

	return velocity
