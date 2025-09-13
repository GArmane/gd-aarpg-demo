@icon("res://assets/icon-godot-node/node-2D/icon_flag.png")
class_name Spawner extends Node2D

signal spawned(scene: Node2D)

@export var scene: PackedScene
@export var autospawn := false


func spawn() -> void:
	if not scene:
		push_error("Spawnee not defined.")
		return
	var instance = scene.instantiate()
	get_parent().add_child(instance)
	instance.global_position = global_position
	spawned.emit(instance)


func _ready() -> void:
	visible = false
	if autospawn:
		spawn.call_deferred()
