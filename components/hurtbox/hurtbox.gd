@icon("res://assets/icon-godot-node/node-2D/icon_area_meteo.png")

class_name Hurtbox extends Area2D

signal damaged(damage: int)


func take_damage(damage: int) -> void:
	damaged.emit(damage)
