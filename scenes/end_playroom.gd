extends Area2D

var placedBlock1 := false
var placedBlock2 := false
var placedBlockPyramid := false
var oneWay := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (placedBlock1 && placedBlock2 && placedBlockPyramid):
		if not oneWay:
			oneWay = true
			print("playroom finished")
			# turm umfallen lassen, manuell
			await get_tree().create_timer(2).timeout
			var nodes = get_tree().get_nodes_in_group("block")
			for node in nodes:
				if node and node.is_inside_tree():
					node.queue_free()
			var target_node = get_node("finalBlocks")
			if target_node:
				target_node.visible = true
			
			await get_tree().create_timer(3).timeout

			var parent = get_parent() as Playroom
			parent._on_scene_end()



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("block"):
		if body.name == "Block_Little":
			print("placedBlock1 = true")
			placedBlock1 = true
		if body.name == "Block_Little2":
			print("placedBlock2 = true")
			placedBlock2 = true
		if body.name == "BlockPyramid":
			print("placedBlockPyramid = true")
			placedBlockPyramid = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("block"):
		if body.name == "Block_Little":
			print("placedBlock1 = false")
			placedBlock1 = false
		if body.name == "Block_Little2":
			print("placedBlock2 = false")
			placedBlock2 = false
		if body.name == "BlockPyramid":
			print("placedBlockPyramid = false")
			placedBlockPyramid = false
