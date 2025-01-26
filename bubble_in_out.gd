extends Node
class_name BubbleInOut

@onready var bubble_in_sound = $BubbleInSound
@onready var bubble_out_sound = $BubbleOutSound

func _ready() -> void:
	bubble_in()

func bubble_in() -> void:
	bubble_in_sound.play()

func bubble_out() -> void:
	bubble_out_sound.play()
	await bubble_out_sound.finished
