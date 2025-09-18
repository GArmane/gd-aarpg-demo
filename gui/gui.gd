class_name GUI extends Control

signal unpause

@export var _debug_action: GUIDEAction
@export var _pause_action: GUIDEAction
@export var _unpause_action: GUIDEAction

var _player: Player


func setup(player: Player) -> void:
	_player = player


func _ready() -> void:
	# Setup HUD elements
	%DebugHUD.setup_player(_player)
	%PlayerHUD.setup_player(_player)
	# Setup actions
	_debug_action.triggered.connect(_on_debug_action_triggered)
	_pause_action.triggered.connect(_on_pause_action_triggered)
	_unpause_action.triggered.connect(_on_unpause_action_triggered)
	# Setup scene transitions
	LevelManager.level_loaded.connect(func(_level: Node2D): %SceneTransition.fade = true)
	LevelManager.level_load_started.connect(
		func(_level_path: String): %SceneTransition.fade = false
	)


func _on_debug_action_triggered() -> void:
	%DebugHUD.toggle()


func _on_pause_action_triggered() -> void:
	%DebugLayer.visible = false
	%PauseLayer.visible = true


func _on_unpause_action_triggered() -> void:
	%DebugLayer.visible = true
	%PauseLayer.visible = false
	unpause.emit()
