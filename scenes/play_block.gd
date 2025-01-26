extends RigidBody2D

@onready var drop_sound = $DropSound

func change_position(new_position: Vector2) -> void:
	global_position = new_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	# print(body.name)
	if body.name == "player":
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		call_deferred("change_position", Vector2(540, 300))
	else:
		var velocity_scaled_volume = linear_velocity.length() / 1000
		drop_sound.volume_db = -10 + 20 * velocity_scaled_volume
		drop_sound.play()
		#print("block fall on ground sound placeholder"	)
