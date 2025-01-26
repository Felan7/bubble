extends AnimatedSprite2D

signal end_reached

signal position_change(new_position) 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = position.x -400 * delta
	position_change.emit($carry_anchor.global_position)
	if position. x < 0:
		#end scene
		end_reached.emit()
		process_mode = PROCESS_MODE_DISABLED
		
		
	
