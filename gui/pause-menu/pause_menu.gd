extends Control


func _ready() -> void:
	%InventoryDescription.text = ""
	hide_menu()


func attach_player(player: Player) -> void:
	player.inventory_changed.connect(func(inventory): %InventoryHUD.data = inventory)


func hide_menu() -> void:
	visible = false


func show_menu() -> void:
	%SaveButton.grab_focus()
	visible = true


func _on_inventory_hud_item_selected(ref: InventoryButton) -> void:
	%InventoryDescription.text = ref.data.description


func _on_inventory_hud_no_item_selected() -> void:
	%InventoryDescription.text = ""


func _on_save_button_pressed() -> void:
	SaveManager.save_game()
	EventBus.unpause.emit()


func _on_load_button_pressed() -> void:
	SaveManager.load_game()
	EventBus.unpause.emit()
