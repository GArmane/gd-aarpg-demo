class_name DebugLayer extends Control

enum State { HIDDEN, SHOW_GUIDE, SHOW_STATE_CHART }

@export var inital_state := State.HIDDEN
@onready var state: State:
	set(value):
		state = value
		match state:
			State.HIDDEN:
				_show_elements([])
			State.SHOW_GUIDE:
				_show_elements([%GuideDebugger])
			State.SHOW_STATE_CHART:
				_show_elements([%StateChartDebugger])


func setup_player(player: Player) -> void:
	%StateChartDebugger.debug_node(player)


func toggle() -> void:
	state = ((state + 1) % State.size()) as State


func _show_elements(elements: Array[Control] = []):
	visible = !elements.is_empty()
	get_children().map(func(child): child.visible = child in elements)


func _ready() -> void:
	state = inital_state
