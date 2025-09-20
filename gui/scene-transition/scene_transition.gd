class_name SceneTransition extends Control

signal fade_started
signal fade_finished

@onready var _fade := false:
	set(value):
		_fade = value
		match _fade:
			true:
				%AnimationPlayer.play("Scene Transitions/fade_in")
			false:
				%AnimationPlayer.play("Scene Transitions/fade_out")


func toggle() -> bool:
	fade_started.emit()
	_fade = !_fade
	await %AnimationPlayer.animation_finished
	fade_finished.emit()
	return _fade
