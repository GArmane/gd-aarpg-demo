extends Node


func _ready() -> void:
	pass


func start_game(main_scene: String) -> void:
	var player := PlayerManager.setup_player()
	GUIController.setup_gui(player)

	var level := await LevelManager.load_level(main_scene)
	level.spawn_actor_at_spawn_point(player)
	level.actor_traveling_to.connect(_on_actor_travelling_to)


func _on_actor_travelling_to(
	level_path: String,
	actor: Player,
	target_transition_area: String,
	position_offset: Vector2,
) -> void:
	if actor is not Player:
		return
	# Forcefully unparent player before a level is cleaned.
	PlayerManager.unparent_player()
	# Load and setup new level.
	var level := await LevelManager.load_level(level_path)
	level.spawn_player_at_transition_area(actor, target_transition_area, position_offset)
	level.actor_traveling_to.connect(_on_actor_travelling_to)
