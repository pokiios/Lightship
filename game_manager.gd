class_name GameManager 
extends Node3D

var player : PlayerBoat
@export var spawn_positions : Array[Marker3D]
@export var home_port_ids : Array[int]
@export var dialog_ids : Array[int]
@export var npc_scene: PackedScene


var current_npc : NPCBoat
var timer_for_dialogue : Timer
var current_index : int = 0

var is_tut_test_wasd : bool = false
var is_tut_test_map : bool = false
var tut_don_bay : bool = false

var has_w : bool = false
var has_a : bool = false
var has_s : bool = false
var has_d : bool = false

var has_m_1 : bool = false
var has_m_2 : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for each in get_parent().get_children():
		if each is PlayerBoat:
			player = each
	timer_for_dialogue = Timer.new()
	self.add_child(timer_for_dialogue)
	timer_for_dialogue.one_shot = true
	timer_for_dialogue.timeout.connect(new_radio_message)
	
	%"Dialog Box".tut_wasd.connect(tut_test_wasd)
	%"Dialog Box".tut_map.connect(tut_test_map)
	%"Dialog Box".tut_done.connect(tut_test_done)
	%"Dialog Box".total_dialog_end.connect(Game_Over)
	
	var timer_for_tut_delay = Timer.new()
	self.add_child(timer_for_tut_delay)
	timer_for_tut_delay.timeout.connect(on_tut_start)
	timer_for_tut_delay.one_shot = true
	timer_for_tut_delay.start(3)
	

	
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.keycode == KEY_0:
		%"Dialog Box".dialog_progression = 63
		new_radio_message()
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not tut_don_bay:
		if is_tut_test_wasd:
			if Input.is_action_just_pressed("Forward"):
				has_w = true
			if Input.is_action_just_pressed("Backward"):
				has_s = true
			if Input.is_action_just_pressed("Left"):
				has_a = true
			if Input.is_action_just_pressed("Right"):
				has_d = true
		if has_w and has_a and has_s and has_d:
			on_tut_start()
			is_tut_test_wasd = false
			has_w = false
			has_a = false
			has_d = false
			has_s = false
			
			
		if is_tut_test_map:
			if Input.is_action_just_pressed("Map"):
				if has_m_1 == false:
					has_m_1 = true
				else:
					has_m_2 = true
					
					
		if has_m_1 and has_m_2:
				on_tut_start()
				is_tut_test_map = false
				has_m_1 = false
				has_m_2 = false
	pass

func spawn_boat(spawn_pos, home_port_id):
	current_npc = npc_scene.instantiate()
	get_parent().add_child(current_npc)

	current_npc.global_position = spawn_pos.global_position
	current_npc.home_port_id = home_port_id
	current_npc.home_now.connect(on_current_boat_home)
	current_npc.picked_up.connect(on_picked_up)
	
func on_current_boat_home():
	timer_for_dialogue.start(randi_range(5,10))
	pass 

func on_picked_up():
	%"Dialog Box".dialog_progression += 1
	%"Dialog Box".open_dialog_screen()

func new_radio_message():
#her is where the code for new dialogue go
	%"Dialog Box".dialog_progression += 1
	%"Dialog Box".open_dialog_screen()
	#then spawn boat
	spawn_boat(spawn_positions[current_index], home_port_ids[current_index])
	
	current_index += 1
	pass
	
func on_tut_start():
	%"Dialog Box".dialog_progression += 1
	%"Dialog Box".open_dialog_screen()
	
func tut_test_wasd():
	is_tut_test_wasd = true
	pass
	
func tut_test_map():
	is_tut_test_map = true
	pass
	
func tut_test_done():
	tut_don_bay = true
	timer_for_dialogue.start(randi_range(5,10))
	
func Game_Over():
	var end_timer := Timer.new()
	end_timer.one_shot = true
	add_child(end_timer)
	end_timer.start()
	await end_timer.timeout
	get_tree().change_scene_to_file("res://Scenes/Menu/GameFinishedMenu.tscn")
	pass
