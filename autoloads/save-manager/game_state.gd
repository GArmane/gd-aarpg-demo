@icon("res://assets/icon-godot-node/node/icon_save.png")
class_name GameState extends Resource

@export var current_loaded_scene: String
@export var current_player_data: Dictionary


func _init(
	p_current_loaded_scene = "",
	p_current_player_data = {},
) -> void:
	current_loaded_scene = p_current_loaded_scene
	current_player_data = p_current_player_data
