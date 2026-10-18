class_name GameManager 
extends Node3D

var player : PlayerBoat
@export var spawn_positions : Array[Marker3D]
@export var home_port_ids : Array[int]
var current_npc : NPCBoat
var timer_for_dialogue : Timer
var current_index : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for each in get_parent().get_children():
		if each is PlayerBoat:
			player = each
	timer_for_dialogue = Timer.new()
	timer_for_dialogue.timeout.connect(new_radio_message)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_boat(spawn_pos, home_port_id):
	current_npc = NPCBoat.new()
	current_npc.position = spawn_pos
	current_npc.home_port_id = home_port_id
	current_npc.home_now.connect(on_current_boat_home)
	
func on_current_boat_home():
	timer_for_dialogue.start(randi_range(5,10))
	pass 

func new_radio_message():
#her is where the code for new dialogue go

	#then spawn boat
	spawn_boat(spawn_positions[current_index], home_port_ids[current_index])
	
	current_index += 1
	pass
	
