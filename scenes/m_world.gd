extends Node2D

@onready var music = $Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var synchronized_stream = music.stream as AudioStreamSynchronized
	var _music_prefix = "res://art/music/Bubbles of Thoughts - "

	var _music_mapping = {
		"mountain" : "Berg",
		"eyes" : "Bild",
		"thank_you" : "Danke",
		"concert" : "Konzert",
		"tower" : "Turm",
	}

	synchronized_stream.stream_count = Global.scene_ids.size()

	var index = 0
	for scene_id in Global.scene_ids:
		if Global.scene_completion_state[scene_id]:
			synchronized_stream.set_sync_stream(index, load(_music_prefix + _music_mapping[scene_id] + ".wav"))
		index += 1

	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
