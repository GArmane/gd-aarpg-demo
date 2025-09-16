class_name GUI extends Control

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
