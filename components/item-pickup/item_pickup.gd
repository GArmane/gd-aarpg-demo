@tool
@icon("res://assets/icon-godot-node/node-2D/icon_money_bag.png")
class_name ItemPickup extends CharacterBody2D

const FRICTION_FACTOR := 2

@export var item: Item:
	set(value):
		item = value
		_update_texture()


func _ready() -> void:
	_update_texture()

	if Engine.is_editor_hint():
		return

	if velocity:
		%AnimationPlayer.play("Movement/Bounce")


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	velocity -= velocity * (FRICTION_FACTOR * delta)


func _update_texture() -> void:
	%ItemSprite.texture = item.texture if item != null else null


func _on_area_2d_body_entered(body: Player) -> void:
	if body.inventory == null or body.inventory.add_item(item) != OK:
		return

	%PickupTrigger.set_deferred("monitorable", false)
	%PickupTrigger.set_deferred("monitoring", false)
	%ItemSprite.visible = false
	%PickupSound.play()
	await %PickupSound.finished
	queue_free()
