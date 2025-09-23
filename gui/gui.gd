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
	# Setup HUD elements
	# Setup canvas layers
	%DebugLayer.visible = (%DebugHUD.state != DebugHUD.State.HIDDEN)
	%OverlayLayer.visible = true
	# Connect to event bus
	EventBus.pause.connect(_on_event_bus_pause_triggered)
	EventBus.unpause.connect(_on_event_bus_unpause_triggered)
	# Setup actions
	_debug_action.triggered.connect(_on_debug_action_triggered)
	_unpause_action.triggered.connect(_on_unpause_action_triggered)


func _on_debug_action_triggered() -> void:
	var state = %DebugHUD.toggle()
	%DebugLayer.visible = (state != DebugHUD.State.HIDDEN)


func _on_unpause_action_triggered() -> void:
	EventBus.unpause.emit()


func _on_event_bus_pause_triggered() -> void:
	%DebugLayer.visible = false
	%PauseLayer.visible = true
	%PauseMenu.show_menu()


func _on_event_bus_unpause_triggered() -> void:
	%DebugLayer.visible = true
	%PauseLayer.visible = false
	%PauseMenu.hide_menu()
