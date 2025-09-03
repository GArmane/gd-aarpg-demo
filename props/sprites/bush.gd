extends Node2D


func _on_hurtbox_damaged(_damage: int) -> void:
	queue_free()
