extends Node2D

const SUMMIT_X = 17000

@onready var player = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.summit_x = SUMMIT_X

	for node in get_tree().get_nodes_in_group("cloud"):
		if node is Cloud:
			node.summit_x = SUMMIT_X
			node.offset_x = -2000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
