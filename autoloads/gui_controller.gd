extends Node

var _gui_scene = preload("res://gui/gui.tscn")
var _current_gui: GUI


## Get current active GUI, or create one if no GUI has been created.
func get_current_gui() -> GUI:
	if _current_gui == null:
		_current_gui = _gui_scene.instantiate()
		add_sibling.call_deferred(_current_gui)
	return _current_gui
