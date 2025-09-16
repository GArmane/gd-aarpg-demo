@tool
class_name AreaTransition extends Area2D

signal travel_to(level, actor, target_area_transition, offset)

@export_file("*.tscn") var level
@export var target_area_transition: String = "AreaTransition"

@export_category("Collision Area Settings")
@export_range(1, 12, 1, "or_greater") var size := 1:
	set(value):
		size = value
		_update_collision_shape()
@export var side := SIDE_LEFT:
	set(value):
		side = value
		_update_collision_shape()
@onready var _collision_shape_2d := $CollisionShape2D


func place_actor(actor: Actor2D, offset: Vector2) -> void:
	actor.global_position = global_position + offset


func _ready() -> void:
	_update_collision_shape()

	if Engine.is_editor_hint():
		return


func _get_body_offset(body: Node2D) -> Vector2:
	var offset := Vector2.ZERO

	if side == SIDE_LEFT or side == SIDE_RIGHT:
		offset.y = body.position.y - global_position.y
		offset.x = 16 if side == SIDE_RIGHT else -16
	else:
		offset.x = body.position.x - global_position.x
		offset.y = 16 if side == SIDE_BOTTOM else -16
	return offset


func _update_collision_shape() -> void:
	var new_rect := Vector2(32, 32)
	var new_pos := Vector2.ZERO

	if side == SIDE_TOP:
		new_rect.x *= size
		new_pos.y -= 16
	elif side == SIDE_BOTTOM:
		new_rect.x *= size
		new_pos.y += 16
	elif side == SIDE_LEFT:
		new_rect.y *= size
		new_pos.x -= 16
	elif side == SIDE_RIGHT:
		new_rect.y *= size
		new_pos.x += 16

	if _collision_shape_2d == null:
		_collision_shape_2d = get_node("%CollisionShape2D")

	_collision_shape_2d.shape.size = new_rect
	_collision_shape_2d.position = new_pos


func _on_body_entered(body: Actor2D) -> void:
	if body is Actor2D:
		travel_to.emit(level, body, target_area_transition, _get_body_offset(body))
