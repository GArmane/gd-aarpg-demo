class_name GUI extends Control

@export var _menu_mode: GUIDEMappingContext
@export var _debug_action: GUIDEAction
@export var _pause_action: GUIDEAction

var _player: Player


func setup_player(player: Player) -> void:
	_player = player


func _ready() -> void:
	# Setup HUD elements
	%DebugHUD.setup_player(_player)
	%PlayerHUD.setup_player(_player)
	# Setup scene transitions
	LevelManager.level_loaded.connect(func(_level: Node2D): %SceneTransition.fade = true)
	LevelManager.level_load_started.connect(
		func(_level_path: String): %SceneTransition.fade = false
	)
	# Setup GUI inputs
	GUIDE.enable_mapping_context(_menu_mode)
	_debug_action.completed.connect(_on_debug_action_completed)
	_pause_action.completed.connect(_on_pause_action_completed)


func _on_debug_action_completed() -> void:
	%DebugHUD.toggle()


func _on_pause_action_completed() -> void:
	print("PAUSE")
