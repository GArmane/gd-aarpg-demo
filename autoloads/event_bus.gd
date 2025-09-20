extends Node

signal pause
signal unpause


func _ready() -> void:
	for event in [pause, unpause]:
		event.connect(_log_event(event.get_name()))


func _log_event(event: String) -> Callable:
	return func(): print("(%s): %s event triggered" % [name, event])
