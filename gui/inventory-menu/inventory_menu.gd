@icon("res://assets/icon-godot-node/control/icon_bag.png")
class_name InventoryMenu extends Control


func _ready() -> void:
	%ItemDescription.text = ""


func attach_player(player: Player) -> void:
	player.inventory_changed.connect(func(inventory): %InventoryHUD.data = inventory)


func _on_inventory_hud_item_selected(ref: InventoryButton) -> void:
	%ItemDescription.text = ref.data.description


func _on_inventory_hud_no_item_selected() -> void:
	%ItemDescription.text = ""
