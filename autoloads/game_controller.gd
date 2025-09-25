extends Node

# GUIDE input game modes
@export var _game_mode: GUIDEMappingContext = preload("res://input/game-mode/game_mode.tres")
@export var _pause_mode: GUIDEMappingContext = preload("res://input/pause-mode/pause_mode.tres")
@export var _debug_mode: GUIDEMappingContext = preload("res://input/debug-mode/debug_mode.tres")


func _ready() -> void:
	EventBus.pause.connect(_on_event_bus_pause)
	EventBus.unpause.connect(_on_event_bus_unpause)
	SaveManager.game_loaded.connect(_on_save_manager_game_loaded)


func start_game(scene_path: String) -> void:
	# Initialize GUI and fade out.
	var gui = GUIController.get_current_gui()
	await gui.set_scene_transition(false)
	# Initialize game, load and setup level.
	var player := _initialize_player()
	var level := await LevelManager.load_level(scene_path)
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	level.spawn_actor_at_spawn_point(player)
	# Setup GUI and fade in.
	gui.attach_player(player)
	await gui.set_scene_transition(true)


func _initialize_player(save_data: Dictionary = {}) -> Player:
	var player := PlayerManager.create_player_chracter()
	player.active.connect(_on_player_active)
	if not save_data.is_empty():
		player.health_points = save_data.health_points
		player.max_health_points = save_data.max_health_points
	return player


func _switch_input_game_modes(
	enable_modes: Array[GUIDEMappingContext],
	disable_modes: Array[GUIDEMappingContext],
):
	disable_modes.map(func(mode): GUIDE.disable_mapping_context(mode))
	enable_modes.map(func(mode): GUIDE.enable_mapping_context(mode))


func _switch_to_game_mode():
	_switch_input_game_modes([_game_mode, _debug_mode], [_pause_mode])
	get_tree().paused = false


func _switch_to_pause_mode():
	_switch_input_game_modes([_pause_mode], [_game_mode, _debug_mode])
	get_tree().paused = true


func _on_actor_travelling_to(
	level_path: String,
	actor: Player,
	target_transition_area: String,
	position_offset: Vector2,
) -> void:
	# Scene travel is currently only for the player character.
	if actor is not Player:
		return
	# Hide current level.
	var gui = GUIController.get_current_gui()
	await gui.set_scene_transition(false)
	# Forcefully unparent player before a level is cleaned.
	PlayerManager.unparent_player()
	# Load and setup new level.
	var level := await LevelManager.load_level(level_path)
	level.spawn_actor_at_transition_area(actor, target_transition_area, position_offset)
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	# Show current level.
	await gui.set_scene_transition(true)


func _on_player_active() -> void:
	_switch_to_game_mode()


func _on_event_bus_pause() -> void:
	_switch_to_pause_mode()


func _on_event_bus_unpause() -> void:
	_switch_to_game_mode()


## Executed while save/load, TODO: refactor with composition
func _on_save_manager_game_loaded(save_data: Dictionary) -> void:
	# Get GUI and fade out.
	var gui = GUIController.get_current_gui()
	await gui.set_scene_transition(false)
	# Initialize game, load and setup level.
	var player := _initialize_player(save_data.player)
	var level := await LevelManager.load_level(save_data["scene_path"])
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	level.spawn_actor_at_global_position(
		player, Vector2(save_data.player.position_x, save_data.player.position_y)
	)
	# Setup GUI and fade in.
	gui.attach_player(player)
	await gui.set_scene_transition(true)
