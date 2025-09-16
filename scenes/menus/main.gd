extends Node2D

@export_file("*.tscn") var start_level


func _ready() -> void:
	await GameController.start_game(start_level)
