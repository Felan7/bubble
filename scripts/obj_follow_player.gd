extends CharacterBody2D

@export var follow_speed = 100
@export var min_player_distance := 3
var player_pos
var target_pos

func _physics_process(delta: float) -> void:
	var player := %player
	if player:
		player_pos = player.position
		target_pos = (player_pos - self.position).normalized()

		if self.position.distance_to(player_pos) > min_player_distance:
			velocity = target_pos * follow_speed
			move_and_slide()
			look_at(player_pos)
