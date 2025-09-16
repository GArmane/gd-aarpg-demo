class_name BaseLevel extends Node2D

@export var spawn_point: Marker2D


## Attach a GUI instance to current level for rendering.
## [gui]: should be a initialized GUI node.
func attach_gui(gui: GUI) -> void:
	add_child(gui)
	move_child(gui, 0)


## Spawn an instanced actor in the default scene spawn point.
## [actor]: should be an instanced actor.
##
## If a spawn point is not defined, errors with a message.
## Otherwise returns spawned actor at designated spawn point.
func spawn_actor_at_spawn_point(actor: Actor2D) -> void:
	assert(spawn_point != null, "(%s): spawn point not defined" % name)
	add_child(actor)
	actor.global_position = spawn_point.global_position


## Spawn an instanced actor in based on a transition area.
## [player]: should be an instanced actor.
## [target_area_transition]: should be a valid transition area child node.
## [position_offset]: should be the position in reference to the transition area.
##
## If a transition area is not found, errors out with a message.
## Otherwise returns spawned actor at designated transition area.
func spawn_player_at_transition_area(
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
	target_area: String,
	position_offset: Vector2,
) -> void:
	GameController.travel_to_level(level, actor, target_area, position_offset)
