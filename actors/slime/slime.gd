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
	},
	"Stunned":
	{
		"base_animation": "Combat/Stun",
		"event": "Stunned",
		"knockback_speed": 300,
	},
	"Dead":
	{
		"base_animation": "Combat/Death",
	},
}


func _ready() -> void:
	%StateChart.set_expression_property.call_deferred("hitpoints", hitpoints)


func _on_idle_state_entered() -> void:
	update_animation(state_configuration["Idle"]["base_animation"])
	var duration: Vector2 = state_configuration["Idle"]["duration"]
	%WanderingTimer.start(randf_range(duration.x, duration.y))


func _on_idle_state_physics_processing(delta: float) -> void:
	if %WanderingTimer.is_stopped():
		%StateChart.send_event(state_configuration["Idle"]["timer_transition_to"])
	else:
		update_movement(delta)


func _on_wandering_state_entered() -> void:
	# Set random direction with animation
	cardinal_direction = DIRECTION_NAMES.keys()[randi() % 4]
	update_animation(state_configuration["Wandering"]["base_animation"])
	# Set timer based on direction
	var cycle_duration: Vector2i = state_configuration["Wandering"]["cycle_duration"]
	%WanderingTimer.start(
		randi_range(cycle_duration.x, cycle_duration.y) * %AnimationPlayer.current_animation_length
	)


func _on_wandering_state_physics_processing(delta: float) -> void:
	if %WanderingTimer.is_stopped():
		%StateChart.send_event(state_configuration["Wandering"]["timer_transition_to"])
	else:
		update_movement(delta, cardinal_direction)


func _on_hitpoints_changed(_old_value: Variant, _new_value: Variant) -> void:
	%StateChart.set_expression_property.call_deferred("hitpoints", hitpoints)


func _on_hurtbox_damaged(damage: int, knockback_direction: Vector2) -> void:
	hitpoints -= damage
	if hitpoints > 0:
		velocity = knockback_direction * state_configuration["Stunned"]["knockback_speed"]
		%StateChart.send_event(state_configuration["Stunned"]["event"])


func _on_stunned_state_entered() -> void:
	update_animation(state_configuration["Stunned"]["base_animation"])


func _on_stunned_state_physics_processing(delta: float) -> void:
	update_movement(delta)
	if not %AnimationPlayer.is_playing():
		%StateChart.send_event(state_configuration["Idle"]["event"])


func _on_dead_state_entered() -> void:
	update_animation(state_configuration["Dead"]["base_animation"])
	await %AnimationPlayer.animation_finished
	queue_free()
