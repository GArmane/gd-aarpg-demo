class_name PlayerHUD extends Control


func attach_player(player: Player) -> void:
	var stats = player.stat_sheet
	%PlayerHealthControl.set_max_health_points(stats.max_health_points)
	%PlayerHealthControl.set_health_points(stats.health_points)
	stats.changed.connect(func(): _update_values(stats))


func _update_values(stats: StatSheet) -> void:
	if stats.health_points < 0 or stats.max_health_points < 0:
		return
	%PlayerHealthControl.set_max_health_points(stats.max_health_points)
	%PlayerHealthControl.set_health_points(stats.health_points)
