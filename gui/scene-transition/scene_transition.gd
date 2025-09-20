class_name SceneTransition extends Control

@onready var _fade := false:
	set(value):
		_fade = value
		match _fade:
			true:
				%AnimationPlayer.play("Scene Transitions/fade_in")
			false:
				%AnimationPlayer.play("Scene Transitions/fade_out")


func toggle() -> bool:
	_fade = !_fade
	await %AnimationPlayer.animation_finished
	return _fade
