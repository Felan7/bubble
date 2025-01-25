extends Node2D

# bubble animation parameters
@export var rotation_amplitude: float = 2.5
@export var position_amplitude: float = 0.3
@export var speed: float = 1.2

signal bubble_enter(bubble_name, target)
signal bubble_leave
var bubble_name : String = ""
var scene_target_path : String = "" 


func _on_area_2d_body_entered(body: Node2D) -> void:
	bubble_enter.emit(bubble_name, scene_target_path)


func _on_area_2d_body_exited(body: Node2D) -> void:
	bubble_leave.emit()

# bubble animation
var time_passed: float = 0.0  # Timer

func _process(delta: float) -> void:
	time_passed += delta
	rotation_degrees = rotation_amplitude * sin(time_passed * speed)
	position.y = position.y + position_amplitude * sin(time_passed * speed)
