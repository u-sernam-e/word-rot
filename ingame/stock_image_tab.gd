extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_open : bool = false

func _on_open_button_pressed() -> void:
	if is_open == false:
		is_open = true
		
		animated_sprite_2d.play("default")


func _on_close_button_pressed() -> void:
	if is_open == true:
		is_open = false
	
		animated_sprite_2d.play_backwards("default")
