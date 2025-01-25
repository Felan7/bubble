extends CharacterBody2D

@export var follow_speed := 240.0
var player

func _ready() -> void:
	player = get_parent().player

# eye object
func _physics_process(delta: float) -> void:	
	velocity = Vector2.ZERO
	if player:
		var player_pos = player.global_position
		var target_pos = (player_pos - self.global_position).normalized()
		velocity = target_pos * follow_speed
		move_and_slide()
		look_at(player_pos)


func _on_overlap_collider_body_entered(body) -> void:
	if body.name == "player":
		print("Kollision mit dem Player erkannt!")
