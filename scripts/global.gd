extends Node
var scene_ids = ["mountain", "eyes", "thank_you", "concert", "stargazing", "tower"]
var scene_completion_state = {}


func end_game():
	get_tree().change_scene_to_file("res://scenes/game_over_called.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for scene_id in scene_ids:
		scene_completion_state[scene_id] = false

	# Testing
	# scene_completion_state["eyes"] = true
	# scene_completion_state["concert"] = true
