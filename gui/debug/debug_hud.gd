class_name DebugLayer extends CanvasLayer


func setup_player(player: Player) -> void:
	%StateChartDebugger.initial_node_to_watch = player.get_path()


## TODO: should be controlled by the GUI node, with state machine.
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_debug"):
		visible = !visible
