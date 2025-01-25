extends Node2D


signal bubble_enter(bubble_name)
signal bubble_leave
var bubble_name : String = "bubbelig"
var scene_target : PackedScene = preload("res://scenes/hub.tscn")


func change_scene():
	get_tree().root.add_child(scene_target.instantiate())


func _on_area_2d_body_entered(body: Node2D) -> void:
	bubble_enter.emit(bubble_name)


func _on_area_2d_body_exited(body: Node2D) -> void:
	bubble_leave.emit()
