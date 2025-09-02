class_name Slime extends Actor2D

@export var state_configuration := {
	"Idle":
	{
		"base_animation": "Movement/Idle",
		"event": "Idle",
		"duration": Vector2(1, 3),
		"timer_transition_to": "Wandering"
	},
	"Wandering":
	{
		"base_animation": "Movement/Walk",
		"event": "Wandering",
		"cycle_duration": Vector2i(1, 3),
		"timer_transition_to": "Idle"
	}
}


func _on_idle_state_entered() -> void:
	update_animation(state_configuration["Idle"]["base_animation"])
	var duration: Vector2 = state_configuration["Idle"]["duration"]
	%Timer.start(randf_range(duration.x, duration.y))


func _on_idle_state_processing(delta: float) -> void:
	if %Timer.is_stopped():
		%StateChart.send_event(state_configuration["Idle"]["timer_transition_to"])
	else:
		update_movement(delta)


func _on_wandering_state_entered() -> void:
	# Set random direction with animation
	cardinal_direction = DIRECTION_NAMES.keys()[randi() % 4]
	update_animation(state_configuration["Wandering"]["base_animation"])
	# Set timer based on direction
	var cycle_duration: Vector2i = state_configuration["Wandering"]["cycle_duration"]
	%Timer.start(
		randi_range(cycle_duration.x, cycle_duration.y) * %AnimationPlayer.current_animation_length
	)


func _on_wandering_state_processing(delta: float) -> void:
	if %Timer.is_stopped():
		%StateChart.send_event(state_configuration["Wandering"]["timer_transition_to"])
	else:
		update_movement(delta, cardinal_direction)
