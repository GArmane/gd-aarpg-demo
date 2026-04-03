extends Node

signal tilemap_bounds_changed(bounds: TilemapLayerBounds)

var current_scene: Node2D:
	get():
		return get_tree().current_scene
var current_tilemap_bounds: TilemapLayerBounds


func _ready():
	EventBus.loot_generated.connect(_on_event_bus_loot_generated)


func change_tilemap_bounds(bounds: TilemapLayerBounds) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)


func load_level(level_path: String) -> Level:
	# Pause current scene so it can finish any process leftover.
	var scene_tree = get_tree()
	scene_tree.paused = true
	await scene_tree.process_frame

	## Load new level.
	var res = scene_tree.change_scene_to_file(level_path)
	assert(res == OK, "(%s): Failed to load level with status %s" % [name, res])

	## Unpause scene and resume game.
	scene_tree.paused = false
	await scene_tree.process_frame

	return scene_tree.current_scene as Level


func _on_event_bus_loot_generated(arr: Array[ItemPickup]):
	for element in arr:
		current_scene.add_child.call_deferred(element)
