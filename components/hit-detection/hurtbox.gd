@icon("res://assets/icon-godot-node/node-2D/icon_area_meteo.png")

class_name Hurtbox extends Area2D

signal damaged(source: Hitbox, target: Hurtbox, data: Variant)


func receive_hit(source: Hitbox, data: Variant) -> bool:
	damaged.emit(source, self, data)
	return true
