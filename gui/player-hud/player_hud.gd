class_name PlayerHUD extends Control


func attach_player(player: Player) -> void:
	var stat_sheet = player.stat_sheet
	%PlayerHealthControl.set_max_health_points(stat_sheet.max_health_points.value)
	%PlayerHealthControl.set_health_points(stat_sheet.health_points.value)
	stat_sheet.health_points_changed.connect(
		func(value): %PlayerHealthControl.set_health_points(value)
	)
	stat_sheet.max_health_points_changed.connect(
		func(value):
			if value < 0:
				return
			%PlayerHealthControl.set_max_health_points(value)
			%PlayerHealthControl.set_health_points(stat_sheet.health_points.value)
	)
