extends Node

var _player_scene = preload("res://actors/player/player.tscn")
var _current_player: Player


## Get current instanced player.
func get_current_player() -> Player:
	assert(_current_player != null, "(%s): player not properly setup" % name)
	return _current_player


## Setup a player character.
func setup_player() -> Player:
	_current_player = _player_scene.instantiate()
	return _current_player


func unparent_player() -> Player:
	var player := get_current_player()
	var parent = player.get_parent()
	if parent != null:
		parent.remove_child(player)
	return player
