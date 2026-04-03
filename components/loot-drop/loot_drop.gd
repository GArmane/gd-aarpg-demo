@icon("res://assets/icon-godot-node/node/icon_money_bag.png")
class_name LootDrop extends Node

signal loot_generated(arr: Array[ItemPickup])

const PICKUP := preload("res://components/item-pickup/item_pickup.tscn")

@export var drops: Array[LootDropChance] = []


func generate_loot(where: Vector2) -> Array[ItemPickup]:
	var pickups: Array[ItemPickup] = (
		drops
		. filter(func(drop): return drop.item != null)
		. reduce(_reducer.bind(where), Array([], TYPE_OBJECT, "Node2D", ItemPickup))
	)
	loot_generated.emit(pickups)
	return pickups


func _reducer(acc: Array, drop: LootDropChance, where: Vector2):
	for _i in drop.get_drop_count():
		var pickup := PICKUP.instantiate() as ItemPickup
		pickup.item = drop.item
		pickup.global_position = where + Vector2(randf() * 16, randf() * 16)
		acc.push_back(pickup)
	return acc
