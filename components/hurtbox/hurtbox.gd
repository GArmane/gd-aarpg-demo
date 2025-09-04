@icon("res://assets/icon-godot-node/node-2D/icon_area_meteo.png")

class_name Hurtbox extends Area2D

signal damaged(damage: int, knockback_direction: Vector2, knockback_force: float)


func apply_damage(source: Hitbox) -> void:
	var knockback_direction := (
		source.global_position.direction_to(get_parent().global_position).normalized()
	)
	var knockback_force := source.force
	damaged.emit(source.damage, knockback_direction, knockback_force)
