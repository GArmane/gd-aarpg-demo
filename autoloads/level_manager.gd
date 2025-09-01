class_name LevelManager extends Node

signal tilemap_bounds_changed(bounds: TilemapLayerBounds)

var current_tilemap_bounds: TilemapLayerBounds


func change_tilemap_bounds(bounds: TilemapLayerBounds) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)
