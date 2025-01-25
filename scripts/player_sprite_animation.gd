extends AnimatedSprite2D

# Geschwindigkeit der Rotation in Grad pro Sekunde
@export var rotation_speed = 90.0 # 90 Grad pro Sekunde

func _process(delta):
	# Drehe den Sprite kontinuierlich
	var player := %player
	if player:
		if player.in_transportation_mode:
			rotation_degrees += rotation_speed * delta
		elif rotation_degrees != 0:
			rotation_degrees = 0
