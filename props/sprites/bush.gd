extends Node2D


func _on_hurtbox_damaged(
	_damage: int,
	_knockback_direction: Vector2,
	_knockback_force: float,
) -> void:
	queue_free()
