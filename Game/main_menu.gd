extends CanvasLayer


func _on_play_game_pressed():
	AudioManager.vine_boom.play()
	LevelTransition.level_count += 1
	LevelTransition.change_scene_to("res://Levels/1.tscn")
