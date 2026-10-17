extends Control

@onready var fold : FoldableContainer = $VBoxContainer/FoldableContainer
@onready var player_dot = $VBoxContainer/FoldableContainer/HBoxContainer/TextureRect/PlayerDot
@onready var texture_map = $VBoxContainer/FoldableContainer/HBoxContainer/TextureRect

@onready var radio_panel = $VBoxContainer/FoldableContainer/HBoxContainer/PanelContainer

var has_message : bool = true

var player : PlayerBoat 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for child in get_parent().get_children():
		if child is PlayerBoat:
			player = child
			break
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if radio_panel != null:
		if has_message and not radio_panel.visible :
			radio_panel.visible = true
		if not has_message and radio_panel.visible:
			radio_panel.visible = false

	
	if Input.is_action_just_pressed("Map"):
		fold.folded = not fold.folded
		
	if player != null:
		var x = player.global_position.x+75
		var z = player.global_position.z+75
		
		x = x/150 * 500
		z = z/150 * 500
		
		player_dot.position = Vector2(x,z)
	pass
