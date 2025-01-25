extends Node2D

@export var rotation_amplitude: float = 2.5
@export var position_amplitude: float = 0.3
@export var speed: float = 1.2

var time_passed: float = 0.0  # Timer

func _process(delta: float) -> void:
	time_passed += delta
	rotation_degrees = rotation_amplitude * sin(time_passed * speed)
	position.y = position.y + position_amplitude * sin(time_passed * speed)
