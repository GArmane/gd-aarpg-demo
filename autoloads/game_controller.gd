extends Node

# GUIDE input game modes
@export var _game_mode: GUIDEMappingContext = preload("res://input/game-mode/game_mode.tres")
@export var _pause_mode: GUIDEMappingContext = preload("res://input/pause-mode/pause_mode.tres")
@export var _debug_mode: GUIDEMappingContext = preload("res://input/debug-mode/debug_mode.tres")


func _ready() -> void:
	EventBus.pause.connect(_switch_to_pause_mode)
	EventBus.unpause.connect(_switch_to_game_mode)
	SaveManager.game_loaded.connect(_on_save_manager_game_loaded)


func start_game(main_scene: String) -> void:
	# Setup player.
	var player := PlayerManager.setup_player()
	player.active.connect(_switch_to_game_mode)
	# Setup GUI.
	var gui = GUIController.setup_gui(player)
	# Load and setup level.
	var level := await LevelManager.load_level(main_scene)
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	level.spawn_actor_at_spawn_point(player)
	await gui.toggle_scene_transition()


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
	await gui.toggle_scene_transition()
	# Forcefully unparent player before a level is cleaned.
	PlayerManager.unparent_player()
	# Load and setup new level.
	var level := await LevelManager.load_level(level_path)
	level.spawn_player_at_transition_area(actor, target_transition_area, position_offset)
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	# Show current level.
	await gui.toggle_scene_transition()


## Executed while save/load, TODO: refactor with composition
func _on_save_manager_game_loaded(save_data: Dictionary) -> void:
	# Setup player.
	var player := PlayerManager.setup_player()
	player.active.connect(_switch_to_game_mode)
	player.health_points = save_data.player.health_points
	player.max_health_points = save_data.player.max_health_points
	# Load and setup level.
	var level := await LevelManager.load_level(save_data["scene_path"])
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	level.spawn_player_at_global_position(
		player, Vector2(save_data.player.position_x, save_data.player.position_y)
	)
	# Setup GUI.
	var gui = GUIController.setup_gui(player)
	# FIXME: set better default behaviour for GUI, maybe save state??
	await gui.toggle_scene_transition()
	await gui.toggle_scene_transition()
