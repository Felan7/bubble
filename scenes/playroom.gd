extends Node2D
class_name Playroom

var hub_scene : PackedScene = preload("res://scenes/M_World.tscn")

var scene_id = "tower"

func _play_bubble_out_sound() -> void:
	var bubble_in_out = $BubbleInOut as BubbleInOut
	bubble_in_out.bubble_out()
	await bubble_in_out.bubble_out_sound.finished

func _on_scene_end() -> void:
	Global.scene_completion_state["scene_id"] = true
	await _play_bubble_out_sound()
	get_tree().change_scene_to_packed(hub_scene)
