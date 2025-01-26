extends AnimatedSprite2D

signal end_reached

var step_timer = 0.0
var step_timer_max = 0.5

signal position_change(new_position)

@onready var step_sound = $StepSound

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = position.x -400 * delta
	position_change.emit($carry_anchor.global_position)
	if position. x < 0:
		#end scene
		end_reached.emit()
		process_mode = PROCESS_MODE_DISABLED
		
	step_timer += delta

	if step_timer >= step_timer_max:
		step_timer = 0.0

		step_sound.play()
		

	
