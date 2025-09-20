extends Control

signal close_menu


func _ready() -> void:
	hide_menu()


func hide_menu() -> void:
	visible = false


func show_menu() -> void:
	%SaveButton.grab_focus()
	visible = true


func _on_save_button_pressed() -> void:
	SaveManager.save_game()
	close_menu.emit()


func _on_load_button_pressed() -> void:
	SaveManager.load_game()
	close_menu.emit()
