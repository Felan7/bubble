extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print(body)
	var block = body.get_node("scenes/Playroom/Block_Little2/Block")
	print(block)
	if body.name == "player":
		block.position = Vector2(850, 730)
		
