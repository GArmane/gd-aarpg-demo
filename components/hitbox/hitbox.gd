@icon("res://assets/icon-godot-node/node-2D/icon_hitbox.png")

class_name Hitbox extends Area2D

@export var damage: int = 1


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.apply_damage(self)
