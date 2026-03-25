@icon("res://assets/icon-godot-node/node-2D/icon_hitbox.png")
class_name Hitbox extends Area2D

signal hit(target: Hurtbox)

# Defines what to send to the hurtbox in case of a hit.
@export var data: Variant


func _on_area_entered(area: Hurtbox) -> void:
	if area.receive_hit(self, data):
		hit.emit(area)
