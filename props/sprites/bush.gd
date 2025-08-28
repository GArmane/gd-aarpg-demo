extends Node2D


func _on_hitbox_damaged(_damage: int) -> void:
	queue_free()
