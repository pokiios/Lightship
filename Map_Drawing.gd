extends TextureRect

var img: Image
var img_texture: ImageTexture

var mouse_on_map: bool = false
var drawing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	img = Image.create(500, 500, false, Image.FORMAT_RGBA8)
	img.fill(Color.TRANSPARENT)
	
	img_texture = ImageTexture.create_from_image(img)
	texture = img_texture
	Input.use_accumulated_input = false
	pass # Replace with function body.

func _input(event):
	# Mouse in viewport coordinates.
	if mouse_on_map:
		if event is InputEventMouseButton:
			#print("Mouse Click/Unclick at: ", get_local_mouse_position())
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					#print("Left button was clicked at ", event.position)
					drawing = true
				else:
					#print("Left button was released")
					
					drawing = false
		
		elif event is InputEventMouseMotion:
			#print("Mouse Motion at: ", get_local_mouse_position())
			if drawing:
				paint_at(get_local_mouse_position().x, get_local_mouse_position().y, Color(0.01, 0.0, 0.215, 1.0))
			
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if drawing:
		#paint_at(get_local_mouse_position().x, get_local_mouse_position().y, Color(0.01, 0.0, 0.215, 1.0))
	pass
	
func paint_at(x: int, y: int, color: Color):
	if x >= 0 and x < img.get_width() and y >= 0 and y < img.get_height():
		for i in range(-3,3):
			for j in range(-3,3):
				
				img.set_pixel(x+i, y+j , color)
		# Update the texture with the modified image
		img_texture.update(img)


func _on_mouse_entered() -> void:
	mouse_on_map = true
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	mouse_on_map = false
	pass # Replace with function body.
