class_name PlayerHUD extends CanvasLayer

@export var player: Player


func _ready():
	await player.ready
	player.health_points_changed.connect(
		func(_old_value, new_value): %PlayerHealthControl.set_health_points(new_value)
	)
	player.max_health_points_changed.connect(
		func(_old_value, new_value):
			%PlayerHealthControl.set_max_health_points(new_value)
			%PlayerHealthControl.set_health_points(player.health_points)
	)
	%PlayerHealthControl.set_max_health_points(player.max_health_points)
	%PlayerHealthControl.set_health_points(player.health_points)
