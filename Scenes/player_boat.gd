extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var max_speed = 15.0
@export var acceleration = 2.0
@export var deceleration = 1.5
@export var max_turn_speed = 2.0
@export var min_turn_speed = 0.3

var current_speed = 0.0

@export var bob_time = 0.0
@export var bob_amount = 0.2
@export var bob_speed = 1.2


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
	
	var move_input = Input.get_axis('Backward', 'Forward')
	var turn_input = Input.get_axis('Right','Left')
	
	if move_input != 0:
		current_speed = move_toward(current_speed, move_input*max_speed, acceleration*delta)
	else:
		current_speed = move_toward(current_speed, 0.0, deceleration*delta)
		
	var speed_ratio = abs(current_speed) / max_speed
	var turn_speed = lerp(min_turn_speed, max_turn_speed, speed_ratio)
	
	rotate_y(turn_input * turn_speed * delta)
	
	velocity = -transform.basis.z * current_speed
	
	bob_time += delta * bob_speed
	var bob_intensity = lerp(bob_amount, bob_amount*0.3, speed_ratio)
	
	$MeshInstance3D.rotation.z = sin(bob_time) * bob_intensity
	
	move_and_slide()

		
