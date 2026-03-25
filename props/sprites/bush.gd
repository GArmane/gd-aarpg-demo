extends Node2D


func _on_hurtbox_damaged(_source: Hitbox, _target: Hurtbox, _data: Variant) -> void:
	queue_free()
