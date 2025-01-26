extends Node2D

func _on_timer_timeout() -> void:
	print("called")
	$VBoxContainer/RichTextLabel.visible = true


func _on_timer_game_over_timeout() -> void:
	get_tree().quit()
