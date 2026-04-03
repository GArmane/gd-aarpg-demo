@icon("res://assets/icon-godot-node/node/icon_save.png")
extends Node

signal game_loaded(state: GameState)

const SAVE_PATH := "user://"
const SAVE_FILE := "game.save"

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


func load_game() -> Error:
	if not ResourceLoader.exists(_file_path):
		return ERR_FILE_NOT_FOUND
	var state = ResourceLoader.load(_file_path, "GameState", ResourceLoader.CACHE_MODE_IGNORE)
	game_loaded.emit(state)
	return OK


func save_game() -> Error:
	var state = GameState.new(
		LevelManager.current_scene.get_scene_file_path(),
		PlayerManager.get_current_player().save_state()
	)
	state.set_path(_file_path)
	var res := ResourceSaver.save(state)
	if res != OK:
		assert(false, "Error: {err}".format({"err": res}))
	return res
