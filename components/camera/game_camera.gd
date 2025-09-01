class_name GameCamera extends Camera2D


func _ready():
	GlobalLevelManager.tilemap_bounds_changed.connect(update_limits)
	update_limits(GlobalLevelManager.current_tilemap_bounds)


func update_limits(bounds: TilemapLayerBounds) -> void:
	limit_left = bounds.top_left.x
	limit_top = bounds.top_left.y
	limit_right = bounds.bottom_right.x
	limit_bottom = bounds.bottom_right.y
