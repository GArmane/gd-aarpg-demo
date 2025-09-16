class_name SceneTransition extends Control

@onready var fade := false:
	set(value):
		fade = value
		match fade:
			true:
				%AnimationPlayer.play("Scene Transitions/fade_in")
			false:
				%AnimationPlayer.play("Scene Transitions/fade_out")
		await %AnimationPlayer.animation_finished


func toggle() -> bool:
	fade = !fade
	return fade
