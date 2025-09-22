extends Node

signal game_loaded(save_data: Dictionary)
signal game_saved(save_data: Dictionary)

const SAVE_PATH := "user://"
const SAVE_FILE := "game.save.json"

var _current_save := {
	scene_path = "",
	player =
	{
		health_points = 4,
		max_health_points = 4,
		position_x = 0,
		position_y = 0,
	},
}


func load_game() -> void:
	var file := FileAccess.open(_get_file_path(), FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	_current_save = json.get_data() as Dictionary
	game_loaded.emit(_current_save)


func save_game() -> void:
	# Create new structure merging current save data with current game data.
	var new_data := _update_player_data(_update_scene_path(_current_save))
	# Open save file and complete operation. TODO: error recovery.
	var file := FileAccess.open(_get_file_path(), FileAccess.WRITE)
	file.store_string(JSON.stringify(new_data))
	# Update current save data with game data
	_current_save = new_data
	# Cleanup process.
	print("(%s): game loaded: %s" % [name, _get_file_path()])
	game_saved.emit(_current_save)


func _get_file_path() -> String:
	return SAVE_PATH + SAVE_FILE


func _update_scene_path(save_data: Dictionary) -> Dictionary:
	return save_data.merged({"scene_path": LevelManager.current_scene.scene_file_path}, true)


func _update_player_data(save_data: Dictionary) -> Dictionary:
	var player = PlayerManager.get_current_player()
	return (
		save_data
		. merged(
			{
				"player":
				{
					health_points = player.health_points,
					max_health_points = player.max_health_points,
					position_x = player.global_position.x,
					position_y = player.global_position.y,
				}
			},
			true
		)
	)
