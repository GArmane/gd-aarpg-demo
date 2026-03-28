@icon("res://assets/icon-godot-node/control/icon_bag.png")
class_name InventoryMenu extends Control

var _inventory: Inventory


func _ready() -> void:
	%ItemDescription.text = ""


func attach_player(player: Player) -> void:
	_inventory = player.inventory
	_inventory.changed.connect(func(): %InventoryHUD.data = _inventory)
	%InventoryHUD.data = _inventory


func _on_inventory_hud_item_selected(ref: InventoryButton) -> void:
	%ItemDescription.text = ref.data.description


func _on_inventory_hud_no_item_selected() -> void:
	%ItemDescription.text = ""


func _on_inventory_hud_buttom_activated(ref: InventoryButton) -> void:
	print(_inventory.activate_item(ref.data.item))


func _on_inventory_hud_buttom_select(ref: InventoryButton) -> void:
	%ItemDescription.text = ref.data.description


func _on_inventory_hud_no_button_selected() -> void:
	%ItemDescription.text = ""
