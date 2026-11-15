extends CanvasLayer


func _on_play_game_pressed():
	AudioManager.sound_effect_1.play()
	AudioManager.vine_boom.play()
	LevelTransition.level_count += 1
	LevelTransition.change_scene_to("res://Levels/" + str(LevelTransition.level_count) + ".tscn")
