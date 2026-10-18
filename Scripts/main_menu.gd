extends Control

@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton

@export var scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_play_button_animation_finished() -> void:
	get_tree().change_scene_to_packed(scene)
	pass # Replace with function body.

func _on_quit_button_animation_finished() -> void:
	get_tree().quit(0)
	pass # Replace with function body.
