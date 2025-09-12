class_name PlayerHUD extends CanvasLayer


func _ready():
	$PlayerHealthControl.set_health_points(5, 5)
