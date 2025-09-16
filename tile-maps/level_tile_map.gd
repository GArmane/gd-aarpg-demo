class_name LevelTileMap extends TileMapLayer


func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())


func get_tilemap_bounds() -> TilemapLayerBounds:
	var rect = get_used_rect()
	return (
		TilemapLayerBounds
		. new(
			rect.position * rendering_quadrant_size,
			rect.end * rendering_quadrant_size,
		)
	)
