extends Node2D

@export var _walk_mode: GUIDEMappingContext


func _ready() -> void:
	GUIDE.enable_mapping_context(_walk_mode)
