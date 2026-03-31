extends Node

#region GUIDE input modes
@export var _game_mode: GUIDEMappingContext = preload("res://input/game-mode/game_mode.tres")
@export var _pause_mode: GUIDEMappingContext = preload("res://input/pause-mode/pause_mode.tres")
@export var _debug_mode: GUIDEMappingContext = preload("res://input/debug-mode/debug_mode.tres")
#endregion


#region Engine callbacks
func _ready() -> void:
	EventBus.pause.connect(_on_event_bus_pause)
	EventBus.unpause.connect(_on_event_bus_unpause)


#endregion


#region Game handlers
func start_game(initial_scene: String) -> void:
	# Initialize GUI and fade out.
	var gui := GUIController.get_current_gui()
	await gui.set_scene_transition(false)
	# Initialize the initial level.
	var level := await _setup_level(initial_scene)
	# Initialize the player character.
	_setup_player(gui, level)
	# Fade in the level.
	await gui.set_scene_transition(true)


func _setup_level(path: String) -> Level:
	var level := await LevelManager.load_level(path)
	level.actor_traveling_to.connect(_on_actor_travelling_to)
	return level


func _setup_player(gui: GUI, level: Level) -> Player:
	var player := _initialize_player()
	level.spawn_actor_at_spawn_point(player)
	gui.attach_player(player)
	return player


func _initialize_player() -> Player:
	var player := PlayerManager.create_player_chracter()
	player.active.connect(_on_player_active)
	return player


func _on_actor_travelling_to(
	level_path: String,
	target_transition_area: String,
	position_offset: Vector2,
	actor: Player,
) -> void:
	# Scene travel is currently only for the player character.
	if actor is not Player:
		return
	# Hide current level.
	var gui := GUIController.get_current_gui()
	await gui.set_scene_transition(false)
	# Forcefully unparent player before a level is cleaned.
	PlayerManager.unparent_player()
	# Load and setup new level.
	var level := await _setup_level(level_path)
	level.spawn_actor_at_transition_area(actor, target_transition_area, position_offset)
	# Show current level.
	await gui.set_scene_transition(true)


#endregion


#region Input modes handling
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


#endregion


#region Signal handlers
func _on_player_active() -> void:
	_switch_to_game_mode()


func _on_event_bus_pause() -> void:
	_switch_to_pause_mode()


func _on_event_bus_unpause() -> void:
	_switch_to_game_mode()
#endregion
