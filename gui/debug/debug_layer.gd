class_name DebugLayer extends CanvasLayer


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_debug"):
		visible = !visible
