class_name TilemapLayerBounds extends Resource

var top_left: Vector2i
var bottom_right: Vector2i


static func from_array(bounds: Array[Vector2i]) -> TilemapLayerBounds:
	return TilemapLayerBounds.new(bounds[0], bounds[1])


func _init(top_left_bound: Vector2i, bottom_right_bound: Vector2i) -> void:
	top_left = top_left_bound
	bottom_right = bottom_right_bound
