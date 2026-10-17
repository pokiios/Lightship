extends CharacterBody3D

@export var bob_time = 0.0
@export var bob_amount = 0.2
@export var bob_speed = 1.2

@export var max_speed = 10
@export var acceleration = 2.0
@export var deceleration = 3.5

var current_speed = 0.0


var following : bool = false
var player : PlayerBoat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	if following:
		if abs(global_position.distance_to(player.Booty.global_position)) > 2:
			current_speed = move_toward(current_speed, max_speed, acceleration*delta)
		else:
			current_speed = move_toward(current_speed, player.current_speed, deceleration*delta)
		velocity = global_position.direction_to(player.Booty.global_position) * current_speed
		

		look_at(player.global_position, Vector3.UP)


	bob_time += delta * bob_speed
	#var bob_intensity = lerp(bob_amount, bob_amount*0.3, speed_ratio)
	
	$MeshInstance3D.rotation.z = sin(bob_time+1) *0.4 # * bob_intensity
	
	move_and_slide()
	pass


func _on_notice_zone_area_entered(area: Area3D) -> void:
	
	if area.get_parent() is PlayerBoat:
		following = true
		player = area.get_parent()
	elif area.get_parent() is Port:
		queue_free()
	pass # Replace with function body.
