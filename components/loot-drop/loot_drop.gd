@icon("res://assets/icon-godot-node/node/icon_money_bag.png")
class_name LootDrop extends Node

signal loot_generated(arr: Array[ItemPickup])

const PICKUP := preload("res://components/item-pickup/item_pickup.tscn")
const VELOCITY := 10

@export var drops: Array[LootDropChance] = []


func generate_loot(source: Node2D) -> Array[ItemPickup]:
	var pickups: Array[ItemPickup] = (
		drops
		. filter(func(drop): return drop.item != null)
		. reduce(
			_reducer.bind(source),
			Array([], TYPE_OBJECT, "CharacterBody2D", ItemPickup),
		)
	)
	loot_generated.emit(pickups)
	return pickups


func _reducer(acc: Array, drop: LootDropChance, source: Node2D):
	for _i in drop.get_drop_count():
		var pickup := PICKUP.instantiate() as ItemPickup
		var angle_variance := randf_range(-1.5, 1.5)
		var velocity_variance := randf_range(0.9, 1.5)
		pickup.item = drop.item
		pickup.global_position = source.global_position
		pickup.velocity = source.velocity.rotated(angle_variance) * velocity_variance
		acc.push_back(pickup)
	return acc
