extends Node2D

@export var rotation_amplitude: float = 2.5
@export var position_amplitude: float = 0.3
@export var scale_amplitude: float = 0.01
@export var speed: float = 3.0

var time_passed: float = 0.0  # Timer

func _process(delta: float) -> void:
	time_passed += delta
	rotation_degrees = rotation_amplitude * sin(time_passed * speed)
	position.y = position.y + position_amplitude * sin(time_passed * speed)
	var scale_factor = 1 + scale_amplitude * sin(time_passed * speed)
	scale = Vector2(scale_factor, scale_factor)
