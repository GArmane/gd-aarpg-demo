class_name Level extends Node2D

signal actor_traveling_to(level, actor, target_area_transition, position_offset)

@export var spawn_point: Marker2D


## Spawn an instanced actor at designated global position.
## [actor]: should be an instanced actor.
func spawn_actor_at_global_position(actor: Actor2D, target_position: Vector2) -> void:
	add_child(actor)
	actor.global_position = target_position


## Spawn an instanced actor in the default scene spawn point.
## [actor]: should be an instanced actor.
##
## If a spawn point is not defined, errors with a message.
## Otherwise returns spawned actor at designated spawn point.
func spawn_actor_at_spawn_point(actor: Actor2D) -> void:
	assert(spawn_point != null, "(%s): spawn point not defined" % name)
	spawn_actor_at_global_position(actor, spawn_point.global_position)


## Spawn an instanced actor in based on a transition area.
## [player]: should be an instanced actor.
## [target_area_transition]: should be a valid transition area child node.
## [position_offset]: should be the position in reference to the transition area.
##
## If a transition area is not found, errors out with a message.
## Otherwise returns spawned actor at designated transition area.
func spawn_actor_at_transition_area(
	actor: Actor2D,
	target_area_transition: String,
	position_offset: Vector2,
) -> void:
	var transition = find_child(target_area_transition, true) as AreaTransition
	assert(transition != null, "(%s): area transition not found" % name)
	add_child(actor)
	transition.place_actor(actor, position_offset)


func _ready() -> void:
	y_sort_enabled = true


func _on_area_transition_travel_to(
	level: String,
	actor: Actor2D,
	target_area_transition: String,
	position_offset: Vector2,
) -> void:
	actor_traveling_to.emit(level, actor, target_area_transition, position_offset)
