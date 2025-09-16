class_name GUI extends Node

var _player: Player

@onready var debug_hud := $DebugHUD
@onready var player_hud := $PlayerHUD


func setup_player(player: Player) -> void:
	_player = player


func _ready() -> void:
	debug_hud.setup_player(_player)
	player_hud.setup_player(_player)
