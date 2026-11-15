extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var stock_image_controller: ImageController = $StockImageController

var is_open : bool = false

func _on_open_button_pressed() -> void:
	if is_open == false:
		is_open = true
		
		animated_sprite_2d.play("default")
		await animated_sprite_2d.animation_finished
		
		stock_image_controller.toggle_use(true)
		
		$AnimatedSprite2D/CloseButton.show()

func _on_close_button_pressed() -> void:
	if is_open == true:
		is_open = false
		
		await stock_image_controller.toggle_use(false)
		
		animated_sprite_2d.play_backwards("default")
		await animated_sprite_2d.animation_finished
		
		$AnimatedSprite2D/CloseButton.hide()
