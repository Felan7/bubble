extends Node2D

const SUMMIT_X = 1700
var scene_id = "mountain"
@onready var player : CharacterBody2D = $CharacterBody2D
var dialouge_summmit = load("res://dialogues/mountain_peak.dialogue")
var dialouge_start = load("res://dialogues/mountain_start.dialogue")
var dialouge_end
@onready var dialogue = $ExampleBalloon
var hub_scene : PackedScene = preload("res://scenes/M_World.tscn")
var summit_reached : bool = false

@onready var parent = $Sprite_Parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.summit_x = SUMMIT_X
	
	parent.position_change.connect(_on_parent_position_change)

	for node in get_tree().get_nodes_in_group("cloud"):
		if node is Cloud:
			node.summit_x = SUMMIT_X
			node.offset_x = -2000
	DialogueManager.show_dialogue_balloon(dialouge_start, "start")
	DialogueManager.connect("dialogue_ended", _on_dialouge_ended)

func _on_parent_position_change(new_position):
	player.position = new_position

func _on_dialouge_ended(resource):
	if resource == dialouge_summmit:
		#player hops on parent
		parent.animation = "arm_up"
		#todo play jump sound
		var tween = get_tree().create_tween()
		tween.tween_property(player, "position", parent.get_node("carry_anchor").global_position, 1)
		parent.process_mode = Node.PROCESS_MODE_ALWAYS
	elif resource == dialouge_end:
				
		# end of scene
		print("End of " + scene_id + " scene")
		Global.scene_completion_state[scene_id] = true
		get_tree().change_scene_to_packed(hub_scene)
	

	
func _process(_delta: float) -> void:
	if player.position.x > SUMMIT_X and not summit_reached:
		player.get_node("Sprite").animation = "idle"
		summit_reached = true
		player.process_mode = Node.PROCESS_MODE_DISABLED
		DialogueManager.show_dialogue_balloon(dialouge_summmit, "start")
		#todo should be carried down by parent
