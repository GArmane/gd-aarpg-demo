class_name MovementUtils extends Node

const CARDINAL_DIRECTION = {
	Vector2.RIGHT: "Side",
	Vector2.DOWN: "Down",
	Vector2.LEFT: "Side",
	Vector2.UP: "Up",
}


static func angle_to_cardinal_direction(angle: float) -> Vector2:
	return CARDINAL_DIRECTION.keys()[round(angle / TAU * CARDINAL_DIRECTION.size())]
