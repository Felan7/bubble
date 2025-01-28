extends Node2D

const SUMMIT_X = 17000
var scene_id = "mountain"
@onready var player : CharacterBody2D = $CharacterBody2D
var dialouge_summmit = load("res://dialogues/mountain_peak.dialogue")
var dialouge_start = load("res://dialogues/mountain_start.dialogue")
var dialouge_end = load("res://dialogues/mountain_end.dialogue")
var dialouge_wrong_way = load("res://dialogues/mountain_wrong_way.dialogue")

var hub_scene : PackedScene = preload("res://scenes/M_World.tscn")
var summit_reached : bool = false

@onready var parent = $Sprite_Parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.summit_x = SUMMIT_X
	
	# parent.position = Vector2(SUMMIT_X + 32, parent.position.y)
	
	parent.position_change.connect(_on_parent_position_change)
	parent.end_reached.connect(_on_end_reached)

	for node in get_tree().get_nodes_in_group("cloud"):
		if node is Cloud:
			node.summit_x = SUMMIT_X
			node.offset_x = -2000
	DialogueManager.show_dialogue_balloon(dialouge_start, "start")
	DialogueManager.connect("dialogue_ended", _on_dialouge_ended)

func _on_parent_position_change(new_position):
	player.position = new_position

func _on_end_reached():
	DialogueManager.show_dialogue_balloon(dialouge_end, "start")

func _on_dialouge_ended(resource):
	if resource == dialouge_summmit:
		#player hops on parent
		parent.animation = "arm_up"
		#todo play jump sound
		var tween = get_tree().create_tween()
		tween.tween_property(player, "position", parent.get_node("carry_anchor").global_position, 1)
		await tween.finished
		player.get_node("Sprite").animation = "sitting"
		player.get_node("Sprite").flip_h = false
		player.is_sitting = true
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		parent.process_mode = Node.PROCESS_MODE_ALWAYS
		parent.animation = "carry"
	elif resource == dialouge_end:
		# end of scene
		print("End of " + scene_id + " scene")
		Global.scene_completion_state[scene_id] = true

		var bubble_in_out = $BubbleInOut as BubbleInOut
		bubble_in_out.bubble_out()
		await bubble_in_out.bubble_out_sound.finished
		
		get_tree().change_scene_to_packed(hub_scene)
	

	
func _process(_delta: float) -> void:
	if player.position.x > SUMMIT_X and not summit_reached:
		player.get_node("Sprite").animation = "idle"
		summit_reached = true
		player.process_mode = Node.PROCESS_MODE_DISABLED
		DialogueManager.show_dialogue_balloon(dialouge_summmit, "start")
		#todo should be carried down by parent


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		DialogueManager.show_dialogue_balloon(dialouge_wrong_way, "start")
		player.get_node("Sprite").flip_h = false
