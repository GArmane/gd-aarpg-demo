extends Node

var _gui_scene = preload("res://gui/gui.tscn")
var _current_gui: GUI


## Get current active GUI.
func get_current_gui() -> GUI:
	assert(_current_gui != null, "(%s): gui not properly setup" % name)
	return _current_gui


## Setup GUI.
func setup_gui(player: Player) -> GUI:
	_current_gui = _gui_scene.instantiate()
	_current_gui.setup_player(player)
	add_sibling.call_deferred(_current_gui)
	return _current_gui
