extends Node2D
class_name ImageController

@export var center : Vector2
const MAX_WIDTH : int = 600

var images : Array[StockImage] = []
const image_scene = preload("res://ingame/stock_image_controller/image.tscn")

var is_moving_image : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_images()
	for i in images:
		i.button_pressed.connect(_image_button_pressed)
	get_tree().create_timer(0.1).timeout.connect(set_up_image_positions)


func create_images():
	var image = image_scene.instantiate()
	add_child(image)
	images.append(image)
			
# set up word positions in a centered manner
# within the maximum width
func set_up_image_positions():
	var current_row : int = 0
	var current_row_size : int = 0
	var images_row : Array[int] = [] # each value in this array corresponds to a value in words[] array
	for i in images:
		var image_size = i.get_button_size()
		# if row would become too big, create new row
		# need to move all current rows up
		if current_row_size + image_size.x > MAX_WIDTH:
			current_row += 1
			current_row_size = 0
			for row in range(current_row):
				#print(row)
				move_all_in_row(row, images_row, Vector2(0, -image_size.y*0.5))
			
			#print("row move up")
			#print(current_row)
			#print("--")
		else: # adding to current row
			# add size of word to current row
			current_row_size += image_size.x
			# add the required length to all words in current row
			# I think this is a little broken
			move_all_in_row(current_row, images_row, Vector2(-image_size.x*0.5, 0))
		i.position = Vector2(current_row_size*0.5 - image_size.x*0.5, current_row*image_size.y*0.5)
		images_row.append(current_row)
# helper func for set_up_word_positions()
func move_all_in_row(current_row : int, images_row : Array[int], move_amount : Vector2):
	for i in images_row.size():
		var image_row = images_row[i]
		var image = images[i]
		if image_row == current_row:
			image.position += move_amount

func _image_button_pressed(image : StockImage):
	if image.moving:
		var areas = image.centerArea.get_overlapping_areas()
		var shouldGoToOrigin = true
		for a in areas:
			if a.is_in_group("Timeline"):
				if not Globals.image_on_timeline:
					image.moveNode.global_position = Vector2(467, 310)
					shouldGoToOrigin = false
					image.on_timeline = true
					Globals.image_on_timeline = true
		if shouldGoToOrigin:
			image.moveNode.position = Vector2(0, 0)
		image.toggle_move()
		is_moving_image = false
	else:
		if not is_moving_image:
			if image.on_timeline:
				image.on_timeline = false
				Globals.image_on_timeline = false
			image.toggle_move()
			is_moving_image = true

func _process(_delta: float) -> void:
	pass
