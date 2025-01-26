extends Node
var scene_ids = ["mountain", "eyes", "thank_you", "concert", "stargazing", "main"]
var scene_completion_state = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for scene_id in scene_ids:
		scene_completion_state[scene_id] = false

	# Testing
	# scene_completion_state["eyes"] = true
	# scene_completion_state["concert"] = true
