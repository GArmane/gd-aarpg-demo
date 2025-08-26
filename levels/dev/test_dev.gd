extends Node2D

@export var _game_mode: GUIDEMappingContext


func _ready() -> void:
	GUIDE.enable_mapping_context(_game_mode)
