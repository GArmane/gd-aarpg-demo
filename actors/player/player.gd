@icon("res://assets/icon-godot-node/node-2D/icon_human_controller.png")

class_name Player extends Actor2D

@export var state_configuration = {
	"Idle":
	{
		"base_animation": "Movement/Idle",
		"event": "Idle",
	},
	"Walking":
	{
		"base_animation": "Movement/Walk",
		"event": "Walking",
	},
	"Attacking":
	{
		"base_animation": "Combat/Attack",
		"event": "Attacking",
	},
}

@export var _game_mode: GUIDEMappingContext
@export var _move_action: GUIDEAction
@export var _attack_action: GUIDEAction


func _on_root_state_entered() -> void:
	GUIDE.enable_mapping_context(_game_mode)


func _on_root_state_exited() -> void:
	GUIDE.disable_mapping_context(_game_mode)


func _on_idle_state_entered() -> void:
	update_animation(state_configuration["Idle"]["base_animation"])


func _on_idle_state_processing(delta: float) -> void:
	if _move_action.is_triggered() and _move_action.value_axis_2d != Vector2.ZERO:
		%StateChart.send_event(state_configuration["Walking"]["event"])
	elif _attack_action.is_triggered():
		%StateChart.send_event(state_configuration["Attacking"]["event"])
	else:
		update_movement(delta)


func _on_walking_state_cardinal_direction_changed(_old_dir, _new_dir) -> void:
	update_animation(state_configuration["Walking"]["base_animation"])


func _on_walking_state_entered() -> void:
	update_animation(state_configuration["Walking"]["base_animation"])
	cardinal_direction_changed.connect(_on_walking_state_cardinal_direction_changed)


func _on_walking_state_processing(delta: float) -> void:
	if not _move_action.is_triggered() or _move_action.value_axis_2d == Vector2.ZERO:
		%StateChart.send_event(state_configuration["Idle"]["event"])
	elif _attack_action.is_triggered():
		%StateChart.send_event(state_configuration["Attacking"]["event"])
	else:
		update_movement(delta, _move_action.value_axis_2d)


func _on_walking_state_exited() -> void:
	cardinal_direction_changed.disconnect(_on_walking_state_cardinal_direction_changed)


func _on_attacking_state_entered() -> void:
	update_animation(state_configuration["Attacking"]["base_animation"])


func _on_attacking_state_processing(delta: float) -> void:
	update_movement(delta)
	if %AnimationPlayer.is_playing() == false:
		if _move_action.is_triggered():
			%StateChart.send_event(state_configuration["Walking"]["event"])
		else:
			%StateChart.send_event(state_configuration["Idle"]["event"])
