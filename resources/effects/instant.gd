class_name InstantEffect extends Effect

@export var attribute: String
@export var magnitude: int = 1


func apply(stats: StatSheet) -> void:
	stats[attribute] += magnitude
