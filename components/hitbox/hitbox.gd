class_name Hitbox
extends Area2D

signal damaged(damage: int)


func take_damage(damage: int) -> Result:
	print("Took: %s damage" % damage)
	damaged.emit(damage)
	return Result.ok()
