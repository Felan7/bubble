extends Node2D
class_name Spawner

@export var object_scene: PackedScene  # Die Scene, die gespawnt wird
@export var spawn_interval := 1.0  # Zeit zwischen Spawns in Sekunden
@export var spawn_area_size: Vector2 = Vector2(200, 200)  # Bereich für zufällige Spawns
@export var min_distance := 300.0  # Mindestabstand zwischen Objekten

var _timer = 0.0
var spawned_positions: Array = [] # all spawned objects

func _process(delta):
	# Timer erhöhen
	_timer += delta
	if _timer >= spawn_interval:
		_timer = 0.0
		spawn_object()

func is_position_valid(new_position: Vector2) -> bool:
	for existing_position in spawned_positions:
		var player := $player
		if player:
			if existing_position.distance_to(new_position) < min_distance && existing_position != player.global_position:
				return false
	return true

func spawn_object():
	# Instanziere die Scene
	if object_scene:
		var new_position: Vector2
		var valid_spawn_pos = false
		
		for _i in range(100):
			var random_offset = Vector2(
				randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
				randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
			)
			new_position = position + random_offset
			if is_position_valid(new_position):
				# spawn position is valid (no overlaps)
				valid_spawn_pos = true
				break
		
		if valid_spawn_pos:
			# Instanziere die Scene und setze die Position
			var instance = object_scene.instantiate()
			instance.number_test = 10014
			var player_ref := $player
			instance.player = player_ref
			instance.position = new_position
			get_tree().current_scene.add_child(instance)

			# Speichere die Position
			spawned_positions.append(new_position)
