extends Node2D


signal bubble_enter(bubble_name, target)
signal bubble_leave
var bubble_name : String = ""
var scene_target_path : String = "" 


func _on_area_2d_body_entered(body: Node2D) -> void:
	bubble_enter.emit(bubble_name, scene_target_path)


func _on_area_2d_body_exited(body: Node2D) -> void:
	bubble_leave.emit()
