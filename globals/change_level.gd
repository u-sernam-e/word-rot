extends Node

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

var level_count: int = 0
var scene_to_load: String

var color_rect_tween: Tween

func change_scene_to(scene_path: String) -> void:
	color_rect.visible = true
	if color_rect_tween:
		color_rect_tween.kill()
		
	scene_to_load = scene_path
	get_tree().paused = true
	
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	
	_load_new_scene()
	
func _load_new_scene() -> void:
	get_tree().call_deferred("change_scene_to_file", scene_to_load)
	animation_player.play("fade")
	await animation_player.animation_finished
	color_rect.visible = false
	get_tree().paused = false
