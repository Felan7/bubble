extends Node2D
var scene_id = "stargazing"
var resource = load("res://dialogues/" + scene_id + ".dialogue")
@onready var dialogue = $ExampleBalloon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(resource, "start")

	Global.scene_completion_state[scene_id] = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
