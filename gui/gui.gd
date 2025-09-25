class_name GUI extends Control

@export var _debug_action: GUIDEAction
@export var _unpause_action: GUIDEAction


func attach_player(player: Player) -> GUI:
	%DebugHUD.attach_actor(player)
	%PlayerHUD.attach_player(player)
	return self


func set_scene_transition(state := true) -> void:
	%SceneTransition.fade = state
	await %SceneTransition.transition_ended


func _ready() -> void:
	# Setup canvas layers
	%DebugLayer.visible = (%DebugHUD.state != DebugHUD.State.HIDDEN)
	%PauseLayer.visible = false
	%OverlayLayer.visible = true
	# Event bus signals
	EventBus.pause.connect(_on_event_bus_pause)
	EventBus.unpause.connect(_on_event_bus_unpause)
	# GUIDE actions signals
	_debug_action.triggered.connect(_on_debug_action_triggered)
	_unpause_action.triggered.connect(_on_unpause_action_triggered)


func _on_event_bus_pause() -> void:
	%DebugLayer.visible = false
	%PauseLayer.visible = true
	%PauseMenu.show_menu()


func _on_event_bus_unpause() -> void:
	%DebugLayer.visible = true
	%PauseLayer.visible = false
	%PauseMenu.hide_menu()


func _on_debug_action_triggered() -> void:
	var state = %DebugHUD.toggle()
	%DebugLayer.visible = (state != DebugHUD.State.HIDDEN)


func _on_unpause_action_triggered() -> void:
	EventBus.unpause.emit()
