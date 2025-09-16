class_name BaseLevel extends Node2D


func _ready() -> void:
	LevelManager.level_load_started.connect(_on_level_load_started)
	LevelManager.level_loaded.connect(_on_level_loaded)
	y_sort_enabled = true


func _on_level_loaded(player: Player, target_transition: String, position_offset: Vector2) -> void:
	add_child(player)
	var transition = find_child(target_transition, true) as LevelTransition
	if transition == null:
		var msg = "(%s): Transition node not found." % name
		assert(false, msg)
		push_error(msg)
	transition.place_body(player, position_offset)


func _on_level_load_started(player: Player) -> void:
	remove_child(player)
	queue_free()
