extends Node2D
var scene_id = "stargazing"
var resource = load("res://dialogues/" + scene_id + ".dialogue")
var hub_scene : PackedScene = preload("res://scenes/M_World.tscn")
@onready var dialogue = $ExampleBalloon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(resource, "start")
	DialogueManager.connect("dialogue_ended", _on_dialouge_ended)



func _on_dialouge_ended(resource):
	# end of scene
	print("End of " + scene_id + " scene")
	Global.scene_completion_state["scene_id"] = true
	get_tree().change_scene_to_packed(hub_scene)
