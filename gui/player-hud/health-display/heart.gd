@icon("res://assets/icon-godot-node/control/icon_heart.png")
class_name HeartGUIElement extends Control

enum State { EMPTY = 0, HALF = 1, FULL = 2 }

@onready var frame := State.EMPTY:
	get():
		return %Sprite2D.frame
	set(value):
		%Sprite2D.frame = value
