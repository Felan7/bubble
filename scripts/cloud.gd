extends Sprite2D
class_name Cloud

@export var velocity: Vector2 = Vector2.ZERO
@export var offset_x: int = 0

var summit_x: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x < offset_x:
		position.x = summit_x

	position += velocity * delta
