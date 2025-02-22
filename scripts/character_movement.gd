extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var in_transportation_mode = false
var movement_state = MOVEMENT_STATE.IDLE
var movement_variant = MOVEMENT_VARIANT.WALKING
@onready var sprite = $Sprite
@onready var walking_sound = $WalkingSound
@onready var jump_sound = $JumpSound
@onready var bubble_transport_sound = $BubbleTransportSound
var resource = preload("res://dialogues/phone.dialogue")

var game_over_left_scene : PackedScene = preload("res://scenes/game_over_left.tscn")


enum MOVEMENT_STATE {
	IDLE,
	MOVING
}

enum MOVEMENT_VARIANT {
	WALKING,
	BUBBLE
}

func play_movement_sound():
	if movement_state == MOVEMENT_STATE.MOVING:
		if movement_variant == MOVEMENT_VARIANT.WALKING:
			if not walking_sound.playing:
				walking_sound.play()
		else:
			walking_sound.stop()

		if movement_variant == MOVEMENT_VARIANT.BUBBLE:
			print("play sound")
			if not bubble_transport_sound.playing:
				bubble_transport_sound.play()
		else:
			bubble_transport_sound.stop()

func stop_movement_sound():
	walking_sound.stop()
	bubble_transport_sound.stop()


func change_movement_state(new_state: MOVEMENT_STATE) -> void:
	if new_state != movement_state:
		movement_state = new_state
		if new_state == MOVEMENT_STATE.IDLE:
			sprite.animation = "idle"
		elif new_state == MOVEMENT_STATE.MOVING:
			sprite.animation = "walking"
	if movement_state == MOVEMENT_STATE.IDLE:
		stop_movement_sound()
	else:
		play_movement_sound()

func change_movement_variant(new_variant: MOVEMENT_VARIANT) -> void:
	print("change movement variant to: ", new_variant)
	if new_variant != movement_variant:
		in_transportation_mode = new_variant == MOVEMENT_VARIANT.BUBBLE
		movement_variant = new_variant
		if new_variant == MOVEMENT_VARIANT.WALKING:
			sprite.animation = "walking"
		elif new_variant == MOVEMENT_VARIANT.BUBBLE:
			sprite.animation = "idle"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() && not in_transportation_mode:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

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
	
	if direction_x != 0 or direction_y != 0:
		#is moving
		change_movement_state(MOVEMENT_STATE.MOVING)
	else:
		change_movement_state(MOVEMENT_STATE.IDLE)
		
	if direction_x > 0:
		sprite.flip_h = true
	elif direction_x < 0:
		sprite.flip_h = false
	
	
	if Input.is_action_just_pressed("action") and UI_node.visible:
		if on_phone:
			var pickup_sound = %Telephone/PickupSound
			pickup_sound.play()

			#picking up the phone
			DialogueManager.connect("dialogue_ended", on_dialogue_ended)
			DialogueManager.show_dialogue_balloon(resource, "start")
		elif on_door:
			var open_sound = %Door/OpenSound
			open_sound.play()
			await open_sound.finished

			get_tree().change_scene_to_packed(game_over_left_scene)
		else:
			# change scene
			get_tree().change_scene_to_file(scene_instance)

func on_dialogue_ended(_resource):
	var hangup_sound = %Telephone/HangupSound
	hangup_sound.play()
	DialogueManager.disconnect("dialogue_ended", on_dialogue_ended)

const packed_bubble_scene = preload("res://scenes/bubble.tscn")
const BUBBLES = [
	{
		"name" : "Mountains",
		"target" : "mountain",
		"x" : -2000,
		"y" : 1000
	},
	{
		"name" : "Eyes",
		"target" : "eyes_dialouge",
		"x" : 1800,
		"y" : 400
	},
	{
		"name" : "Concert",
		"target" : "concert",
		"x" : 1000,
		"y" : -1000
	},
	{
		"name" : "Stargazing",
		"target" : "stargazing",
		"x" : -1700,
		"y" : -400
	},
	{
		"name" : "Playroom",
		"target" : "playroom",
		"x" : 2200,
		"y" : -1600
	},
	{
		"name" : "Thank you",
		"target" : "thank_you",
		"x" : 3000,
		"y" : 0
	},
	
]

func _ready() -> void:
	for i in range(BUBBLES.size()):
		var new_bubble = packed_bubble_scene.instantiate()
		new_bubble.name = BUBBLES[i]["name"]
		new_bubble.bubble_name = BUBBLES[i]["name"]
		new_bubble.scene_target_path = "res://scenes/" + BUBBLES[i]["target"] + ".tscn"
		new_bubble.set_position(Vector2(BUBBLES[i]["x"],BUBBLES[i]["y"]))
		new_bubble.bubble_enter.connect(_on_bubble_enter)
		new_bubble.bubble_leave.connect(_on_bubble_leave)
		get_tree().root.get_node("Node2D").add_child.call_deferred(new_bubble)
		UI_node.visible = false
	

var scene_instance
@onready var UI_node = $Camera2D/CanvasLayer
@onready var label = $Camera2D/CanvasLayer/Panel/Label
func _on_bubble_leave():
	UI_node.visible = false

func _on_bubble_enter(bubble_name, target):
	UI_node.visible = true
	label.text = "Press \"E\" to enter " + bubble_name
	scene_instance = target

var on_phone = false
var on_door = false

func _on_telephone_area_2d_body_entered(body: Node2D) -> void:
	label.text = "Press \"E\" to pick up the phone"
	on_phone = true
	UI_node.visible = true

func _on_telephone_area_2d_body_exited(body: Node2D) -> void:
	on_phone = false
	UI_node.visible = false

func _on_door_area_2d_body_entered(body: Node2D) -> void:
	label.text = "Press \"E\" to open the door"
	print(body.name)
	on_door = true
	UI_node.visible = true

func _on_door_area_2d_body_exited(body: Node2D) -> void:
	on_door = false
	UI_node.visible = false
