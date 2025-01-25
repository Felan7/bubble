extends Area2D

var is_player_inside = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_character := %player
	if player_character:
		if player_character.in_transportation_mode && self.is_player_inside:
			var transport_bubble := get_node("Transport_Bubble")
			if transport_bubble:
				transport_bubble.position = player_character.global_position

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):  # Überprüfen, ob es der Spieler ist
		var player = body
		if not player.in_transportation_mode:
			player.in_transportation_mode = true
			self.is_player_inside = true
			var target := get_node("Transport_Bubble")
			if target:
				player.position = target.global_position
		else:
			player.in_transportation_mode = false
			self.is_player_inside = false
			player.position = self.global_position
