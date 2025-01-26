extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var in_transportation_mode = false
var movement_state = MOVEMENT_STATE.IDLE
var movement_variant = MOVEMENT_VARIANT.WALKING
var player_state = PLAYER_STATE.ALIVE
@onready var sprite = $Sprite
@onready var walking_sound = $WalkingSound
@onready var jump_sound = $JumpSound
@onready var bubble_transport_sound = $BubbleTransportSound
@onready var death_sound = $DeathSound
@onready var music = $Music

enum PLAYER_STATE {
	ALIVE,
	DEAD
}

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

func change_player_state(new_state: PLAYER_STATE) -> void:
	if new_state == PLAYER_STATE.DEAD:
		player_state = new_state
		death_sound.play()
		music.stop()
		sprite.pause()
		await death_sound.finished

		var parent = get_parent() as Spawner
		parent.on_player_death()

func _physics_process(delta: float) -> void:
	if player_state == PLAYER_STATE.DEAD:
		return

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction  = Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down"))
	
	velocity = direction.normalized() * SPEED

	move_and_slide()

	if not in_transportation_mode and direction.x != 0 or direction.y != 0:
		#is moving
		change_movement_state(MOVEMENT_STATE.MOVING)
	else:
		change_movement_state(MOVEMENT_STATE.IDLE)

	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
