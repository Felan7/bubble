extends RigidBody2D

@onready var drop_sound = $DropSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	# print(body.name)
	# print(linear_velocity)
	var velocity_scaled_volume = linear_velocity.length() / 1000
	drop_sound.volume_db = -10 + 20 * velocity_scaled_volume
	drop_sound.play()
	if body.name == "player":
		set_position(Vector2(540, 300))

