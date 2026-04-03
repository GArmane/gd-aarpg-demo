@icon("res://assets/icon-godot-node/node/icon_save.png")
extends Node

signal game_loaded

const SAVE_PATH := "user://"
const SAVE_FILE := "game.save"

var state: GameState:
	get():
		return _state

var _file_ext := ".tres"
var _file_path: String:
	get():
		return (
			"{path}/{file}{fext}"
			. format(
				{
					"path": SAVE_PATH,
					"file": SAVE_FILE,
					"fext": _file_ext,
				}
			)
		)

var _state: GameState


func _ready() -> void:
	if ResourceLoader.exists(_file_path):
		_state = ResourceLoader.load(_file_path, "GameState", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		_state = GameState.new()
		_state.set_path(_file_path)


func load_game() -> Error:
	_state = ResourceLoader.load(_file_path, "GameState", ResourceLoader.CACHE_MODE_IGNORE)
	game_loaded.emit()
	return OK


func save_game() -> Error:
	_state.current_loaded_scene = LevelManager.current_scene.get_scene_file_path()
	_state.current_player_data = PlayerManager.get_current_player().save_state()
	var res := ResourceSaver.save(_state)
	if res != OK:
		assert(false, "Error: {err}".format({"err": res}))
	return res
