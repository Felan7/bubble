extends Node2D
var scene_id = "eyes"
var resource = load("res://dialogues/" + scene_id + ".dialogue")
var hub_scene : PackedScene = preload("res://scenes/follow_eyes.tscn")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(resource, "start")
	DialogueManager.connect("dialogue_ended", _on_dialouge_ended)


func _on_dialouge_ended(resource):
	get_tree().change_scene_to_packed(hub_scene)
