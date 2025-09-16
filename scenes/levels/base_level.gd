class_name BaseLevel extends Node2D

@export var player_spawn_point: Marker2D


## Attach a GUI instance to current level for rendering.
## [gui]: should be a initialized GUI node.
func attach_gui(gui: GUI) -> void:
	add_child(gui)
	move_child(gui, 0)


## Spawn a instanced player in the default scene player spawn point.
## [player]: should be an instanced player.
##
## If a spawn point is not defined, errors with a message.
## Otherwise returns spawn player at designated spawn point.
func spawn_player_at_spawn_point(player: Player) -> void:
	assert(player_spawn_point != null, "(%s): player spawn point not defined" % name)
	add_child(player)
	player.global_position = player_spawn_point.global_position


## Spawn a instanced player in based on a transition area.
## [player]: should be an instanced player.
## [target_area_transition]: should be a valid transition area child.
## [position_offset]: should be the position in reference to the transition area which
## the player is going to spawn.
##
## If a transition area is not found, errors out with a message.
## Otherwise returns spawn player at designated transition area.
func spawn_player_at_transition_area(
	player: Player,
	target_area_transition: String,
	position_offset: Vector2,
) -> void:
	var transition = find_child(target_area_transition, true) as AreaTransition
	assert(transition != null, "(%s): area transition not found" % name)
	add_child(player)
	transition.place_player(player, position_offset)


func _ready() -> void:
	y_sort_enabled = true


func _on_area_transition_travel_to(
	level: String,
	player: Player,
	target_transition: String,
	position_offset: Vector2,
) -> void:
	GameController.travel_to_level(level, player, target_transition, position_offset)
