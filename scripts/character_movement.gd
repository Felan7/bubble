extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var in_transportation_mode = false
@onready var sprite = $Sprite


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() && not in_transportation_mode:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if in_transportation_mode:
		if direction_y:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
	
	move_and_slide()
	if not in_transportation_mode and direction_x != 0 :
		#is moving
		sprite.animation = "walking"
	else:
		sprite.animation = "idle"
		
	if direction_x > 0:
		sprite.flip_h = true
	elif direction_x < 0:
		sprite.flip_h = false
	
	
	if Input.is_action_just_pressed("action") and UI_node.visible:
		# change scene
		get_tree().change_scene_to_file(scene_instance)

const packed_bubble_scene = preload("res://scenes/bubble.tscn")
const BUBBLES = [
	{
		"name" : "Drawing",
		"pretty_name" : "Drawing",
		"target" : "",
		"x" : 1000,
		"y" : 1000
	},
	{
		"name" : "bubble_childhood_mountains",
		"pretty_name" : "Drawing",
		"target" : "",
		"x" : -1000,
		"y" : 1000
	},
	{
		"name" : "Drawing",
		"target" : "eyes",
		"x" : 1000,
		"y" : 0
	},
	{
		"name" : "bubble_youth_concert",
		"target" : "",
		"x" : 1000,
		"y" : -1000
	},
	{
		"name" : "bubble_youth_stargazing",
		"target" : "",
		"x" : 1000,
		"y" : -1000
	},
	{
		"name" : "bubble_youth_gratitude",
		"target" : "",
		"x" : 1000,
		"y" : -1000
	}
	
]

func _ready() -> void:
	for i in range(BUBBLES.size()):
		var new_bubble = packed_bubble_scene.instantiate()
		new_bubble.name = BUBBLES[i]["name"]
		new_bubble.bubble_name = BUBBLES[i]["name"]
		new_bubble.scene_target_path = "res://Scenes/" + BUBBLES[i]["target"] + ".tscn"
		new_bubble.set_position(Vector2(BUBBLES[i]["x"],BUBBLES[i]["y"]))
		new_bubble.bubble_enter.connect(_on_bubble_enter)
		new_bubble.bubble_leave.connect(_on_bubble_leave)
		get_tree().root.add_child.call_deferred(new_bubble)
	

var scene_instance
@onready var UI_node = $Camera2D/CanvasLayer
@onready var label = $Camera2D/CanvasLayer/Panel/Label
func _on_bubble_leave():
	UI_node.visible = false

func _on_bubble_enter(bubble_name, target):
	UI_node.visible = true
	label.text = "Press \"E\" to enter " + bubble_name
	scene_instance = target
