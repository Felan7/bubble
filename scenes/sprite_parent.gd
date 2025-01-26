extends AnimatedSprite2D

signal position_change(new_position) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = position.x -100 * delta
	position_change.emit($carry_anchor.global_position)
	
