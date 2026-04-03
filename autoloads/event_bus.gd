extends Node

signal pause
signal unpause
signal loot_generated(loot: Array[ItemPickup])
signal request_play_gui_audio(stream: AudioStream)


func _ready() -> void:
	for p_signal in [pause, unpause]:
		p_signal.connect(func(): _log_event(p_signal.get_name()))
	for p_signal in [loot_generated, request_play_gui_audio]:
		p_signal.connect(func(_arg): _log_event(p_signal.get_name()))


func _log_event(event_name: String) -> void:
	print("(%s): %s emitted" % [name, event_name])
