extends Node

var _player_scene = preload("res://actors/player/player.tscn")
var _current_player: Player


func get_current_player() -> Player:
	"""Get current instanced player."""
	assert(_current_player != null, "(%s): player not properly setup" % name)
	return _current_player


func setup_player() -> Player:
	"""Setup a player character."""
	_current_player = _player_scene.instantiate()
	return _current_player
