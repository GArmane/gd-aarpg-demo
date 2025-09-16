extends Node


func start_game(main_scene: String) -> void:
	var player := PlayerManager.setup_player()
	var level := await LevelManager.load_level(main_scene)
	level.spawn_player_at_spawn_point(player)


func travel_to_level(
	level_path: String,
	player: Player,
	target_transition_area: String,
	position_offset: Vector2,
) -> void:
	var level := await LevelManager.load_level(level_path)
	level.spawn_player_at_transition_area(player, target_transition_area, position_offset)
