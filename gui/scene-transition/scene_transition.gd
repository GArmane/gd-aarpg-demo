class_name SceneTransition extends Control

signal transition_started
signal transition_ended

@onready var fade := false:
	set(value):
		transition_started.emit()
		fade = value
		match fade:
			true:
				%AnimationPlayer.play("Scene Transitions/fade_in")
			false:
				%AnimationPlayer.play("Scene Transitions/fade_out")
		await %AnimationPlayer.animation_finished
		transition_ended.emit()
