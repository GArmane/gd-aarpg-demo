class_name LevelManager extends Node

signal level_load_started
signal level_loaded
signal tilemap_bounds_changed(bounds: TilemapLayerBounds)

var current_tilemap_bounds: TilemapLayerBounds


func change_tilemap_bounds(bounds: TilemapLayerBounds) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)


func change_to_level(
	player: Player,
	level_path: String,
	target_transition: String,
	position_offset: Vector2,
) -> void:
	# Pause current scene so it can finish any process leftover.
	var scene_tree = get_tree()
	scene_tree.paused = true
	await scene_tree.process_frame

	# Emit level load signal so levels can cleanup.
	level_load_started.emit(player)

	# Load new level and add player to it.
	scene_tree.change_scene_to_file(level_path)
	await scene_tree.process_frame

	# Unpause scene and resume game.
	scene_tree.paused = false
	level_loaded.emit(player, target_transition, position_offset)
