extends Node2D
class_name ImageController

@onready var large_iamge: Sprite2D = $LargeIamge

@export var center : Vector2
const MAX_WIDTH : int = 250

var images : Array[StockImage] = []
const image_scene = preload("res://ingame/stock_image_controller/image.tscn")

var is_moving_image : bool = false

var saved_image : CompressedTexture2D

var stock_images : Array[CompressedTexture2D] = [
	load("res://assets/stockimages/minimizedstockimages/absolute_cinema_min.png"),
	load("res://assets/stockimages/minimizedstockimages/angry_guy_2_min.png"),
	load("res://assets/stockimages/minimizedstockimages/angry_guy_min.png"),
	load("res://assets/stockimages/minimizedstockimages/angry_woman_min.png"),
	load("res://assets/stockimages/minimizedstockimages/chicken_with_glasses_min.png"),
	load("res://assets/stockimages/minimizedstockimages/concerned_dude_min.png"),
	load("res://assets/stockimages/minimizedstockimages/guy_on_banana_phone_min.png"),
	load("res://assets/stockimages/minimizedstockimages/guy_on_phone_min.png"),
	load("res://assets/stockimages/minimizedstockimages/happy_team_min.png"),
	load("res://assets/stockimages/minimizedstockimages/lmk_dog_min.png"),
	load("res://assets/stockimages/minimizedstockimages/nerd_min.png"),
	load("res://assets/stockimages/minimizedstockimages/phone_call_gesture_guy_min.png"),
	load("res://assets/stockimages/minimizedstockimages/scared_dude_min.png"),
	load("res://assets/stockimages/minimizedstockimages/thumbs_up_guy_min.png"),
	load("res://assets/stockimages/minimizedstockimages/woman_on_call_min.png")
]

var large_stock_images : Array = [
	load("res://assets/stockimages/absolute_cinema.png"),
	load("res://assets/stockimages/angry_guy_2.png"),
	load("res://assets/stockimages/angry_guy.png"),
	load("res://assets/stockimages/angry_woman.png"),
	load("res://assets/stockimages/chicken_with_glasses.png"),
	load("res://assets/stockimages/concerned_dude.png"),
	load("res://assets/stockimages/guy_on_banana_phone.png"),
	load("res://assets/stockimages/guy_on_phone.png"),
	load("res://assets/stockimages/happy_team.png"),
	load("res://assets/stockimages/lmk_dog.png"),
	load("res://assets/stockimages/nerd_guy.png"),
	load("res://assets/stockimages/phone_call_gesture_guy.png"),
	load("res://assets/stockimages/scared_dude.png"),
	load("res://assets/stockimages/thumbs_up_guy.png"),
	load("res://assets/stockimages/woman_on_call.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await create_images()
	
	for i in images:
		i.button_pressed.connect(_image_button_pressed)
	get_tree().create_timer(0.1).timeout.connect(set_up_image_positions)
	
	toggle_use(false)

# Called When stock image tab is interacted with
func toggle_use(on : bool):
	for child in get_children():
		if child is StockImage:
			child.visible = on
			child.button.disabled = !on

func create_images():
	for stock in stock_images:
		var image = image_scene.instantiate() as StockImage
		image.initial_set_up(stock)
		
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
					image.moveNode.global_position = Vector2(600, 193)
					shouldGoToOrigin = false
					image.on_timeline = true
					Globals.image_on_timeline = true
					
		if shouldGoToOrigin:
			image.moveNode.position = Vector2(0, 0)
		image.toggle_move()
		is_moving_image = false
		
		await handle_image_tween(true, image)
	else:
		if not is_moving_image:
			if image.on_timeline:
				await handle_image_tween(false, image)
				
				image.on_timeline = false
				Globals.image_on_timeline = false
				
			image.toggle_move()
			is_moving_image = true

func handle_image_tween(on : bool, image : StockImage):
	if Globals.image_on_timeline == false:
		return
	
	var index = stock_images.find(image.button.texture_normal)
	
	if large_iamge.scale == Vector2(3.0, 3.0):
		var tween = create_tween()
		tween.tween_property(large_iamge, "scale", Vector2(0.0, 0.0), 1.2).set_trans(Tween.TRANS_SINE)
		await tween.finished
	
	large_iamge.texture = large_stock_images[index]
	
	if on == true:
		saved_image = large_stock_images[index]
		
		var tween2 = create_tween()
		tween2.tween_property(large_iamge, "scale", Vector2(3.0, 3.0), 1.2).set_trans(Tween.TRANS_SINE)
		await tween2.finished
	else:
		saved_image = null

func get_current_image():
	return saved_image

func _process(_delta: float) -> void:
	pass
