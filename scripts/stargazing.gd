extends Node2D
var scene_id = "stargazing"
var resource = load("res://dialogues/" + scene_id + ".dialogue")
@onready var dialogue = $ExampleBalloon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(resource, "start")

	Global.scene_completion_state[scene_id] = true
	DialogueManager.connect("dialogue_ended", _on_dialouge_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialouge_ended():
	# end of scene
	pass
