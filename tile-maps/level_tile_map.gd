class_name LevelTileMap extends TileMapLayer


func _ready() -> void:
	var bounds = get_tilemap_bounds()
	GlobalLevelManager.change_tilemap_bounds(get_tilemap_bounds())


func get_tilemap_bounds() -> TilemapLayerBounds:
	var rect = get_used_rect()
	return TilemapLayerBounds.new(
		get_used_rect().position * rendering_quadrant_size,
		get_used_rect().end * rendering_quadrant_size
	)
