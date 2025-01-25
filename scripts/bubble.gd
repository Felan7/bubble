extends Node2D

var bubble_name : String = "bubbelig"
var scene_target : PackedScene = preload("res://scenes/hub.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_scene():
	get_tree().root.add_child(scene_target.instantiate())
