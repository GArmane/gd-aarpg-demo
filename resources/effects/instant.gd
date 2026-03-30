class_name InstantEffect extends Effect

@export var attribute: String
@export var magnitude: int = 1
@export var on_apply_audio: AudioStream


func apply(stats: StatSheet) -> void:
	stats[attribute] += magnitude
	if on_apply_audio:
		EventBus.request_play_gui_audio.emit(on_apply_audio)
