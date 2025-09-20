extends Node

signal game_loaded
signal game_saved

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
	game_loaded.emit()
	print("(%s): game loaded: %s" % [name, _get_file_path()])


func save_game() -> void:
	var file := FileAccess.open(_get_file_path(), FileAccess.WRITE)
	var json = JSON.stringify(_current_save)
	file.store_line(json)

	print("(%s): game saved: %s" % [name, _get_file_path()])
	game_saved.emit()


func _get_file_path() -> String:
	return SAVE_PATH + SAVE_FILE
