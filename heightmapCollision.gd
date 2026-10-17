extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var heightmap_texture 
	var heightmap_image = ResourceLoader.load("res://heightmap_h.png")
	heightmap_image.convert(Image.FORMAT_RF)
	
	var width = heightmap_image.get_width()
	var height = heightmap_image.get_height()


	var height_min = 0.0
	var height_max = 6.0
	
	
	
	
	var HMShape = HeightMapShape3D.new()
	HMShape.map_width = width
	HMShape.map_depth = height

	var data = PackedFloat32Array()
	data.resize(width * height)
	
	for i in range(height):
		for j in range(width):
			var pixel_value = heightmap_image.get_pixel(i,j).r
			var y_position = lerp(height_min, height_max, pixel_value)
			data[i *width+j] = y_position
	
	#HMShape.update_map_data_from_image(heightmap_image, height_min, height_max)
	
	HMShape.map_data = data
	
	shape = HMShape
	#scale.x = scale.x/4
	#scale.z = scale.z/4

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
